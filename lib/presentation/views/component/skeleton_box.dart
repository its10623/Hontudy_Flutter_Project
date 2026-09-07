import 'package:flutter/material.dart';

import '../../core/theme/context_theme_extension.dart';

class SkeletonBox extends StatefulWidget {
  final double width, height;
  final BorderRadius? borderRadius;

  const SkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
      ),
    );
  }
}