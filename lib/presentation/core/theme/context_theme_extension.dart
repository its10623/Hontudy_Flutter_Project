import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';

extension ContextExtension on BuildContext {
  TextStyle get captionSmall => TextType.captionSmall.copyWith(
    color: Theme.of(this).colorScheme.onSurfaceVariant,
  );
  TextStyle get captionMedium => TextType.captionMedium.copyWith(
    color: Theme.of(this).colorScheme.onSurfaceVariant,
  );
  TextStyle get captionLarge => TextType.captionLarge.copyWith(
    color: Theme.of(this).colorScheme.onSurfaceVariant,
  );

  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textStyles => Theme.of(this).textTheme;
}
