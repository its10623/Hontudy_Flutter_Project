import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';

extension ContextExtension on BuildContext {
  /// 11sp, Alpha 150
  TextStyle get captionSmall => TextType.captionSmall.copyWith(
    color: Theme.of(this).colorScheme.onSurfaceVariant.withAlpha(150),
  );

  /// 12sp, Alpha 150
  TextStyle get captionMedium => TextType.captionMedium.copyWith(
    color: Theme.of(this).colorScheme.onSurfaceVariant.withAlpha(150),
  );

  /// 13sp, Alpha 150
  TextStyle get captionLarge => TextType.captionLarge.copyWith(
    color: Theme.of(this).colorScheme.onSurfaceVariant.withAlpha(150),
  );

  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textStyles => Theme.of(this).textTheme;
}
