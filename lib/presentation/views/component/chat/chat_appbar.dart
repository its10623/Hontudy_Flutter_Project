import 'package:flutter/material.dart';
import 'package:hontudy/presentation/views/component/divider_widget.dart';

import '../../../core/theme/context_theme_extension.dart';
import '../../../core/theme/shape.dart';
import '../progress_bar_widget.dart';
import 'mascot_avatar.dart';

class ChatAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String pageInfo;
  final String currentState;
  final double? progress;
  final Widget? onNote;
  final Widget? onProfile;

  const ChatAppbar({
    super.key,
    required this.pageInfo,
    required this.currentState,
    this.progress,
    this.onNote,
    this.onProfile,
  });

  static const _progressToolbarHeight = 78.0;

  double get _toolbarHeight =>
      progress != null ? _progressToolbarHeight : kToolbarHeight;

  @override
  Size get preferredSize => Size.fromHeight(_toolbarHeight + 1.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      toolbarHeight: _toolbarHeight,
      titleSpacing: 16,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const MascotAvatar(),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pageInfo,
                      style: context.textStyles.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(currentState, style: context.captionMedium),
                  ],
                ),
              ),
              ?onNote,
              if (onNote != null && onProfile != null)
                const SizedBox(width: 10),
              ?onProfile,
            ],
          ),
          if (progress case final progress?) ...[
            const SizedBox(height: 14),
            _ChatProgressBar(value: progress),
          ],
        ],
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: DividerWidget(),
      ),
    );
  }
}

class _ChatProgressBar extends StatelessWidget {
  final double value;

  const _ChatProgressBar({required this.value});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppShape.pill,
        border: Border.all(color: context.colors.primary.withAlpha(35)),
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: value.clamp(0.0, 1.0)),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        builder: (context, animated, _) => ProgressBarWidget(
          value: animated,
          height: 8,
          backgroundColor: context.colors.surfaceContainerLowest,
        ),
      ),
    );
  }
}
