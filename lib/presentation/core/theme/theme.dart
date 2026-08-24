import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const _colors = FlexSchemeColor(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryContainer,
    secondary: AppColors.primary,
    error: AppColors.error,
  );

  static const _textTheme = TextTheme(
    displayLarge: TextType.displayLarge,
    displaySmall: TextType.displaySmall,
    titleLarge: TextType.titleLarge,
    titleMedium: TextType.titleMedium,
    titleSmall: TextType.titleSmall,
    headlineLarge: TextType.headlineLarge,
    headlineSmall: TextType.headlineSmall,
    bodyLarge: TextType.bodyLarge,
    bodySmall: TextType.bodySmall,
    labelLarge: TextType.labelLarge,
    labelSmall: TextType.labelSmall,
  );

  static ThemeData get light {
    final base = FlexThemeData.light(
      colors: _colors,
      useMaterial3: true,
      textTheme: _textTheme,
    );
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        surface: AppColors.surface,
        surfaceContainerLowest: AppColors.primarySurface,
        surfaceContainerLow: AppColors.surfaceAlt,
        onSurface: AppColors.text,
        onSurfaceVariant: AppColors.textSecondary,
        outline: AppColors.overlayNeutral,
        outlineVariant: AppColors.border,
      ),
    );
  }

  static ThemeData get dark => FlexThemeData.dark(
    colors: _colors,
    useMaterial3: true,
    textTheme: _textTheme,
  );
}
