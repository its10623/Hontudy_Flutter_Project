import 'package:flutter/material.dart';

import '../../core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';

class SkeletonBox extends StatelessWidget {
  final double width, height;
  final BorderRadius? borderRadius;

  const SkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest,
        borderRadius: borderRadius ?? AppShape.badge,
      ),
    );
  }
}
