import 'package:flutter/material.dart';

import '../../core/theme/context_theme_extension.dart';

class ProgressBarWidget extends StatelessWidget {
  final double value;

  const ProgressBarWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      color: context.colors.primary,
      backgroundColor: context.colors.surfaceContainerHighest.withAlpha(30),
      borderRadius: BorderRadius.circular(99),
    );
  }
}
