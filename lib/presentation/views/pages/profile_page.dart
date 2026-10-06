import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/views/component/chip_widget.dart';
import 'package:hontudy/presentation/views/component/divider_widget.dart';

import '../component/app_background.dart';
import '../route/bottom_nav_bar.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _pushEnabled = true;

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: const SafeArea(
          child: BottomNavBar(
            currentIndex: 2,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '마이',
                    style: TextType.titleLarge.copyWith(letterSpacing: -0.5),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _AccountCard(
                        initial: '수',
                        name: '수민님',
                        meta: 'sumin@gmail.com · Google 로그인',
                      ),
                      const SizedBox(height: 16),
                      const _SectionLabel('기억하고 있는 진단 프로필'),
                      const SizedBox(height: 8),
                      const _DiagnosisCard(),
                      const SizedBox(height: 16),
                      _SettingsCard(
                        pushEnabled: _pushEnabled,
                        onPushChanged: (value) =>
                            setState(() => _pushEnabled = value),
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text(
                          '버전 1.0.0 (MVP)',
                          style: TextType.captionMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
  const _DiagnosisCard();

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            children: [
              Expanded(
                child: _StatTile(label: '난이도', value: '2 / 5 · 입문+'),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _StatTile(label: '목적', value: '취업·이직'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: [
              const ChipWidget(
                label: '네트워크',
              ),
              const ChipWidget(
                label: '운영체제',
              ),
              ChipWidget(
                label: '자료구조',
                backgroundColor: context.colors.outline.withAlpha(20),
                textColor: context.colors.outline,
              ),
            ],
          ),
          const SizedBox(height: 12),
          const _RediagnoseRow(),
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
  const _RediagnoseRow();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.primary,
      borderRadius: AppShape.option,
      child: InkWell(
        borderRadius: AppShape.option,
        onTap: () {
          //TODO 재진단 채팅 이동
        },
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
  final bool pushEnabled;
  final ValueChanged<bool> onPushChanged;

  const _SettingsCard({
    required this.pushEnabled,
    required this.onPushChanged,
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
          _SettingsRow(
            label: '푸시 알림',
            trailing: _Toggle(value: pushEnabled, onChanged: onPushChanged),
          ),
          const DividerWidget(),
          const _SettingsRow(label: '로그아웃'),
          const DividerWidget(),
          const _SettingsRow(label: '회원 탈퇴', danger: true),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final String label;
  final Widget? trailing;
  final bool danger;

  const _SettingsRow({
    required this.label,
    this.trailing,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: trailing == null ? () {} : null,
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
            trailing ??
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: context.colors.onPrimary.withAlpha(220),
                ),
          ],
        ),
      ),
    );
  }
}

class _Toggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _Toggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        width: 46,
        height: 28,
        padding: const EdgeInsets.all(3),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        decoration: BoxDecoration(
          color: value
              ? context.colors.primary
              : context.colors.outline.withAlpha(100),
          borderRadius: AppShape.pill,
        ),
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: context.colors.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: context.colors.outlineVariant,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
