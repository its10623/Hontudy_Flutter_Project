import 'package:flutter/material.dart';

import '../../core/theme/context_theme_extension.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final bool wash;

  const AppBackground({
    super.key,
    required this.child,
    this.wash = true,
  });

  @override
  Widget build(BuildContext context) {
    final surface = context.colors.surface;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: surface,
        gradient: wash
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: const Alignment(0, -0.2),
                colors: [
                  Color.alphaBlend(
                    context.colors.primary.withAlpha(40),
                    context.colors.surfaceContainerLowest,
                  ),
                  surface,
                ],
              )
            : null,
      ),
      child: child,
    );
  }
}
