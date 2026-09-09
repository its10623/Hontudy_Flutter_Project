
import 'package:flutter/material.dart';

import '../../core/theme/context_theme_extension.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1.0,
      thickness: 1.0,
      color: context.colors.outlineVariant,
    );
  }
}
