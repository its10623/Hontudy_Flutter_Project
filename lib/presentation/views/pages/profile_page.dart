import 'package:hontudy/presentation/views/route/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hontudy/domain/exceptions.dart';
import 'package:hontudy/domain/models/diagnosis_profile.dart';
import 'package:hontudy/domain/models/user.dart';
import 'package:hontudy/presentation/core/terms_link.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/viewmodels/profile_viewmodel.dart';
import 'package:hontudy/presentation/views/component/chip_widget.dart';
import 'package:hontudy/presentation/views/component/divider_widget.dart';

import '../component/app_background.dart';
import '../component/dialog_widget.dart';
import '../component/error_dialog.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileViewModelProvider);

    return PopScope(
      canPop: !_busy,
      child: AppBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '프로필',
                      style: TextType.titleLarge.copyWith(letterSpacing: -0.5),
                    ),
                  ),
                ),
                if (_busy) const LinearProgressIndicator(),
                Expanded(
                  child: AbsorbPointer(
                    absorbing: _busy,
                    child: profile.when(
                      data: (state) =>
                          _buildContent(state.user, state.diagnosis),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, _) => Center(
                        child: TextButton(
                          onPressed: () =>
                              ref.invalidate(profileViewModelProvider),
                          child: const Text('불러오지 못했어요. 다시 시도'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(User? user, DiagnosisProfile? diagnosis) {
    final name = (user?.displayName.isNotEmpty ?? false)
        ? user!.displayName
        : '이름 없음';
    final provider = switch (user?.authProvider) {
      AuthProvider.google => 'Google 로그인',
      AuthProvider.apple => 'Apple 로그인',
      null => '',
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _AccountCard(
            initial: name.characters.first,
            name: '$name님',
            meta: [
              user?.email ?? '',
              provider,
            ].where((text) => text.isNotEmpty).join(' · '),
          ),
          const SizedBox(height: 16),
          const _SectionLabel('기억하고 있는 진단 프로필'),
          const SizedBox(height: 8),
          _DiagnosisCard(diagnosis: diagnosis, onRediagnose: _rediagnose),
          const SizedBox(height: 16),
          _SettingsCard(
            onTerms: openTermsPage,
            onSignOut: _signOut,
            onDeleteAccount: _deleteAccount,
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text('버전 1.0.0 (MVP)', style: TextType.captionMedium),
          ),
        ],
      ),
    );
  }

  Future<bool> _confirm({
    required String title,
    required String content,
    required String primaryText,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => DialogWidget(
        title: title,
        content: content,
        secondaryText: '취소',
        secondaryOnPressed: () => Navigator.of(dialogContext).pop(false),
        primaryText: primaryText,
        primaryOnPressed: () => Navigator.of(dialogContext).pop(true),
      ),
    );
    return confirmed == true && mounted;
  }

  Future<void> _run(Future<void> Function() action, String next) async {
    setState(() => _busy = true);
    try {
      await action();
      if (!mounted) return;
      context.go(next);
    } on SignInCancelledException {
      return;
    } catch (error) {
      if (!mounted) return;
      await ErrorDialog.show(context: context, error: error);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _rediagnose() async {
    if (!await _confirm(
      title: '다시 진단하기',
      content: '저장된 진단 결과를 지우고 다시 진단해요. 지금까지의 진단 기록도 함께 삭제돼요.',
      primaryText: '다시 진단하기',
    )) {
      return;
    }
    await _run(
      ref.read(profileViewModelProvider.notifier).forgetDiagnosis,
      AppRoutes.diagnosis,
    );
  }

  Future<void> _signOut() => _run(
    ref.read(profileViewModelProvider.notifier).signOut,
    AppRoutes.signIn,
  );

  Future<void> _deleteAccount() async {
    if (!await _confirm(
      title: '회원 탈퇴',
      content: '진단 기록과 풀이 기록이 모두 삭제되고 되돌릴 수 없어요. 본인 확인을 위해 한 번 더 로그인해요.',
      primaryText: '탈퇴하기',
    )) {
      return;
    }
    await _run(
      ref.read(profileViewModelProvider.notifier).deleteAccount,
      AppRoutes.signIn,
    );
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard({
    required this.initial,
    required this.name,
    required this.meta,
  });

  final String initial;
  final String name;
  final String meta;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: AppShape.widgetCard,
        boxShadow: [
          BoxShadow(
            color: context.colors.outlineVariant,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colors.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Text(
              initial,
              style: TextType.titleSmall.copyWith(
                fontWeight: FontWeight.w800,
                color: context.colors.primary,
              ),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextType.headlineSmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  meta,
                  style: TextType.captionMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: context.colors.outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: TextType.captionMedium.copyWith(
          fontWeight: FontWeight.w700,
          color: context.colors.outline,
        ),
      ),
    );
  }
}

class _DiagnosisCard extends StatelessWidget {
  final DiagnosisProfile? diagnosis;
  final VoidCallback onRediagnose;

  const _DiagnosisCard({required this.diagnosis, required this.onRediagnose});

  @override
  Widget build(BuildContext context) {
    final diagnosis = this.diagnosis;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: AppShape.widgetCard,
        boxShadow: [
          BoxShadow(
            color: context.colors.outlineVariant,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (diagnosis == null)
            Text(
              '기억하고 있는 진단 결과가 없어요',
              style: TextType.bodySmall.copyWith(
                color: context.colors.outline,
              ),
            )
          else ...[
            Row(
              children: [
                Expanded(
                  child: _StatTile(
                    label: '난이도',
                    value: '${diagnosis.difficultyScore} / 5',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _StatTile(label: '배경', value: diagnosis.background ?? '-'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _StatTile(label: '목적', value: diagnosis.purposeTags.join(', ')),
            if (diagnosis.weakAreas.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: [
                  for (final area in diagnosis.weakAreas)
                    ChipWidget(label: area),
                ],
              ),
            ],
          ],
          const SizedBox(height: 12),
          _RediagnoseRow(onTap: onRediagnose),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;

  const _StatTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLow,
        borderRadius: AppShape.option,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextType.captionSmall.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colors.outline,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextType.bodyLarge.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _RediagnoseRow extends StatelessWidget {
  final VoidCallback onTap;

  const _RediagnoseRow({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.primary,
      borderRadius: AppShape.option,
      child: InkWell(
        borderRadius: AppShape.option,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI와 다시 진단하기',
                      style: TextType.bodySmall.copyWith(
                        fontWeight: FontWeight.w700,
                        color: context.colors.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '수준이 올라간 것 같으면 언제든',
                      style: TextType.captionSmall.copyWith(
                        color: context.colors.onPrimary.withAlpha(220),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: context.colors.onPrimary.withAlpha(220),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final VoidCallback onTerms;
  final VoidCallback onSignOut;
  final VoidCallback onDeleteAccount;

  const _SettingsCard({
    required this.onTerms,
    required this.onSignOut,
    required this.onDeleteAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: AppShape.widgetCard,
        boxShadow: [
          BoxShadow(
            color: context.colors.outlineVariant,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _SettingsRow(label: '개인정보 및 이용약관', onTap: onTerms),
          const DividerWidget(),
          _SettingsRow(label: '로그아웃', onTap: onSignOut),
          const DividerWidget(),
          _SettingsRow(label: '회원 탈퇴', onTap: onDeleteAccount, danger: true),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool danger;

  const _SettingsRow({
    required this.label,
    required this.onTap,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextType.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: danger ? context.colors.error : null,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: context.colors.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
