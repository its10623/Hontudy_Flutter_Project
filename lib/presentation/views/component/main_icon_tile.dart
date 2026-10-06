import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/main_category_style.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';

/// 1단계 주제 아이콘 타일. muted면 아직 안 푼 주제처럼 회색
class MainIconTile extends StatelessWidget {
  final String main;
  final bool muted;
  final double size;

  const MainIconTile({
    super.key,
    required this.main,
    this.muted = false,
    this.size = 38,
  });

  @override
  Widget build(BuildContext context) {
    final style = MainCategoryStyle.of(context, main);
    final surface = muted
        ? context.colors.outlineVariant.withAlpha(120)
        : style.surface;
    final foreground = muted
        ? context.colors.onSurfaceVariant.withAlpha(110)
        : style.foreground;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: surface,
        borderRadius: AppShape.button,
      ),
      child: SvgPicture.asset(
        style.iconAsset,
        width: size * 0.58,
        height: size * 0.58,
        colorFilter: ColorFilter.mode(foreground, BlendMode.srcIn),
      ),
    );
  }
}
