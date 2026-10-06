import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';

import '../../core/theme/context_theme_extension.dart';

class ProgressBarWidget extends StatelessWidget {
  final double value;
  final Color? color;
  final Color? backgroundColor;
  final double? height;

  const ProgressBarWidget({
    super.key,
    required this.value,
    this.color,
    this.backgroundColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      minHeight: height,
      color: color ?? context.colors.primary,
      backgroundColor:
          backgroundColor ??
          context.colors.surfaceContainerHighest.withAlpha(30),
      borderRadius: AppShape.pill,
    );
  }
}
