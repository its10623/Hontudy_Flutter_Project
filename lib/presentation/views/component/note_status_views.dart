import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hontudy/presentation/views/component/dashed_rrect_painter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hontudy/presentation/core/theme/app_colors.dart';

import '../../core/theme/context_theme_extension.dart';

const _mascotDefaultAsset = 'assets/mascot/mascot_default.svg';
const _mascotOopsAsset = 'assets/mascot/mascot_oops.svg';
const _mascotHappyAsset = 'assets/mascot/mascot_happy.svg';
const _mascotThinkAsset = 'assets/mascot/mascot_think.svg';

class NoteEmptyView extends StatelessWidget {
  const NoteEmptyView({super.key, required this.onStartQuiz});

  final VoidCallback onStartQuiz;

  @override
  Widget build(BuildContext context) {
    return _NoteStatusLayout(
      illustration: const _EmptyIllustration(),
      title: '아직 노트가 비어 있어요',
      message: '문제를 풀면 내 답과 해설이\n주제별로 여기에 쌓여요',
      button: _StatusButton(label: '첫 문제 풀러 가기', onPressed: onStartQuiz),
    );
  }
}

enum NoteDetailEmptyReason {
  noRecords,
  noWrong,
  noCorrect,
}

class NoteDetailEmptyView extends StatelessWidget {
  final NoteDetailEmptyReason reason;

  /// [NoteDetailEmptyReason.noWrong]일 때 "전체 보기" 버튼 동작. null이면 버튼 숨김
  final VoidCallback? onShowAll;
  final VoidCallback? onShowCorrect;

  const NoteDetailEmptyView({
    super.key,
    required this.reason,
    this.onShowAll,
    this.onShowCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return switch (reason) {
      NoteDetailEmptyReason.noRecords => const _NoteStatusLayout(
        illustration: _MascotIllustration(asset: _mascotDefaultAsset),
        title: '이 주제에 저장된 문제가 없어요',
        message: '이 주제의 문제를 풀면\n내 답과 해설이 여기에 쌓여요',
      ),
      NoteDetailEmptyReason.noWrong => _NoteStatusLayout(
        illustration: const _MascotIllustration(asset: _mascotHappyAsset),
        title: '틀린 문제가 없어요',
        message: '이 주제는 지금까지 모두 맞혔어요\n전체 기록에서 다시 볼 수 있어요',
        button: onShowAll == null
            ? null
            : _StatusButton(label: '전체 보기', onPressed: onShowAll),
      ),
      NoteDetailEmptyReason.noCorrect => const _NoteStatusLayout(
        illustration: _MascotIllustration(asset: _mascotThinkAsset),
        title: '아직 맞힌 문제가 없어요',
        message: '틀린 문제를 다시 보면서\n개념을 정리해 보세요',
      ),
    };
  }
}

class NoteLoadErrorView extends StatelessWidget {
  const NoteLoadErrorView({
    super.key,
    required this.onRetry,
    this.isRetrying = false,
  });

  final VoidCallback onRetry;
  final bool isRetrying;

  @override
  Widget build(BuildContext context) {
    return _NoteStatusLayout(
      illustration: const _MascotIllustration(asset: _mascotOopsAsset),
      title: '노트를 불러오지 못했어요',
      message: '저장된 노트는 그대로 있어요.\n잠시 후 다시 시도해주세요.',
      button: _StatusButton(
        label: '다시 불러오기',
        onPressed: isRetrying ? null : onRetry,
        loading: isRetrying,
      ),
    );
  }
}

class _NoteStatusLayout extends StatelessWidget {
  const _NoteStatusLayout({
    required this.illustration,
    required this.title,
    required this.message,
    this.button,
  });

  final Widget illustration;
  final String title;
  final String message;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(28, 24, 28, 110),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            illustration,
            const SizedBox(height: 22),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textStyles.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
                color: context.colors.onSurface,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textStyles.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.6,
                color: context.colors.onSurfaceVariant.withAlpha(180),
              ),
            ),
            if (button case final button?) ...[
              const SizedBox(height: 22),
              button,
            ],
          ],
        ),
      ),
    );
  }
}

class _EmptyIllustration extends StatelessWidget {
  const _EmptyIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 250,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 26,
            left: 0,
            child: _GhostCard(
              angle: -7,
              chipBg: context.colors.primaryContainer,
              chipFg: context.colors.primary,
              label: '운영체제',
            ),
          ),
          const Positioned(
            top: 46,
            left: 130,
            child: _GhostCard(
              angle: 6,
              chipBg: AppColors.correctSurface,
              chipFg: AppColors.correct,
              label: '자료구조',
            ),
          ),
          const _MascotOnShadow(asset: _mascotDefaultAsset),
        ],
      ),
    );
  }
}

class _MascotIllustration extends StatelessWidget {
  const _MascotIllustration({required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 170,
      child: Stack(
        clipBehavior: Clip.none,
        children: [_MascotOnShadow(asset: asset)],
      ),
    );
  }
}

class _MascotOnShadow extends StatelessWidget {
  const _MascotOnShadow({required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          bottom: 4,
          child: Container(
            width: 150,
            height: 22,
            decoration: BoxDecoration(
              color: context.colors.primary.withAlpha(31),
              borderRadius: const BorderRadius.all(Radius.elliptical(75, 11)),
            ),
          ),
        ),
        Positioned(
          bottom: 14,
          child: SvgPicture.asset(asset, width: 112, height: 112),
        ),
      ],
    );
  }
}

class _GhostCard extends StatelessWidget {
  const _GhostCard({
    required this.angle,
    required this.chipBg,
    required this.chipFg,
    required this.label,
  });

  final double angle;
  final Color chipBg;
  final Color chipFg;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Transform.rotate(
        angle: angle * math.pi / 180,
        child: CustomPaint(
          foregroundPainter: DashedRRectPainter(
            color: context.colors.outlineVariant,
            radius: 20,
            strokeWidth: 1.5,
          ),
          child: Container(
            width: 170,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: context.colors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: chipBg,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    label,
                    style: context.textStyles.labelSmall?.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: chipFg,
                    ),
                  ),
                ),
                const SizedBox(height: 9),
                const _GhostLine(widthFactor: 0.92),
                const SizedBox(height: 9),
                const _GhostLine(widthFactor: 0.64),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GhostLine extends StatelessWidget {
  const _GhostLine({required this.widthFactor});

  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        height: 9,
        decoration: BoxDecoration(
          color: context.colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

class _StatusButton extends StatelessWidget {
  const _StatusButton({
    required this.label,
    required this.onPressed,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: context.colors.primary.withAlpha(71),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SizedBox(
        height: 54,
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: context.colors.primary,
            disabledBackgroundColor: context.colors.primary,
            foregroundColor: context.colors.onPrimary,
            disabledForegroundColor: context.colors.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 28),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: context.textStyles.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          child: loading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    color: context.colors.onPrimary,
                  ),
                )
              : Text(label),
        ),
      ),
    );
  }
}
