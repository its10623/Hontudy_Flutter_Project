import 'package:flutter/material.dart';

import '../../../core/theme/context_theme_extension.dart';

class GenUiBox extends StatelessWidget {
  final Widget child;

  const GenUiBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colors.surfaceContainerLowest,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(
              width: 1,
              color: context.colors.outline.withAlpha(50),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
