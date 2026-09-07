import 'package:flutter/material.dart';

import '../../core/theme/context_theme_extension.dart';

class ShimmerWrapper extends StatefulWidget {
  final Widget child;
  const ShimmerWrapper({super.key, required this.child});

  @override
  State<ShimmerWrapper> createState() => _ShimmerWrapperState();
}

class _ShimmerWrapperState extends State<ShimmerWrapper>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = context.colors.surfaceContainerHighest.withAlpha(50);
    final highlight = context.colors.surfaceContainerHighest.withAlpha(150);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) {
          final slide = _controller.value * 2 - 1;
          return LinearGradient(
            colors: [base, context.colors.surfaceContainerHighest.withAlpha(100), highlight, context.colors.surfaceContainerHighest.withAlpha(100), base,],
            stops: [
              _controller.value - 0.6,
              _controller.value - 0.3,
              _controller.value,
              _controller.value + 0.3,
              _controller.value + 0.6,
            ],
            begin: Alignment(-1.0 + slide, 0.0),
            end: Alignment(1.0 + slide, 0.0),
          ).createShader(bounds);
        },
        child: child,
      ),
      child: widget.child,
    );
  }
}