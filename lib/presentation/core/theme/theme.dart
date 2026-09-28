import 'package:auth_buttons/auth_buttons.dart';
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
    error: AppColors.wrong,
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
        onPrimary: AppColors.onPrimary,
        surface: AppColors.surface,
        surfaceContainerLowest: AppColors.primarySurface,
        surfaceContainerHighest: AppColors.overlayNeutral,
        surfaceContainerLow: AppColors.surfaceAlt,
        surfaceContainer: AppColors.codeBlockSurface,
        onSurface: AppColors.text,
        onSurfaceVariant: AppColors.textSecondary,
        outline: AppColors.overlayNeutral,
        outlineVariant: AppColors.border,
      ),
    );
  }

  static ThemeData get dark {
    final base = FlexThemeData.dark(
      colors: _colors,
      useMaterial3: true,
      textTheme: _textTheme,
    );
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        onPrimary: AppColors.onPrimary,
        surface: AppColors.darkSurface,
        surfaceContainerLowest: AppColors.darkPrimarySurface,
        surfaceContainerHighest: AppColors.overlayNeutral,
        surfaceContainerLow: AppColors.surfaceAlt,
        surfaceContainer: AppColors.darkCodeBlockSurface,
        onSurface: AppColors.darkText,
        onSurfaceVariant: AppColors.darkTextSecondary,
        outline: AppColors.overlayNeutral,
        outlineVariant: AppColors.border.withAlpha(100),
      ),
    );
  }

  static const _baseAuthButtonStyle = AuthButtonStyle(
    height: 44,
    borderRadius: 14,
    borderWidth: 0.5,
    borderColor: Color(0xFF747775),
    margin: EdgeInsets.only(bottom: 8.0),
    elevation: 0,
    iconSize: 18,
    separator: 8,
  );

  static AuthButtonStyle googleAuthButtonStyle(bool isDarkMode) {
    if (!isDarkMode) {
      return _baseAuthButtonStyle.copyWith(
          splashColor: Colors.black.withAlpha(15),
          textStyle: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          )
      );
    }
    return _baseAuthButtonStyle.copyWith(
        splashColor: Colors.white.withAlpha(15),
        buttonColor: Colors.black87,
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        )
    );
  }

  static AuthButtonStyle appleAuthButtonStyle(bool isDarkMode) {
    if (!isDarkMode) {
      return _baseAuthButtonStyle.copyWith(
          splashColor: Colors.white.withAlpha(15),
          iconColor: Colors.white,
          buttonColor: Colors.black87,
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          )
      );
    }
    return _baseAuthButtonStyle.copyWith(
      splashColor: Colors.black.withAlpha(15),
      iconColor: Colors.black87,
      buttonColor: Colors.white,
      textStyle: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    );
  }
}
