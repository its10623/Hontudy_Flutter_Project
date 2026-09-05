import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';

extension ContextExtension on BuildContext {
  /// 11sp, onSurfaceVariant 60% 투명도 — 부가 설명/타임스탬프 등 가장 옅은 캡션
  TextStyle get captionSmall => TextType.captionSmall.copyWith(
    color: Theme.of(this).colorScheme.onSurfaceVariant.withAlpha(150),
  );

  /// 12sp, `onSurfaceVariant` 불투명 — 기본 캡션(라벨류 보조 텍스트)
  TextStyle get captionMedium => TextType.captionMedium.copyWith(
    color: Theme.of(this).colorScheme.onSurfaceVariant,
  );

  /// 13sp, `onSurfaceVariant` 60% 투명도 — captionSmall보다 한 단계 큰 옅은 캡션
  TextStyle get captionLarge => TextType.captionLarge.copyWith(
    color: Theme.of(this).colorScheme.onSurfaceVariant.withAlpha(150),
  );

  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textStyles => Theme.of(this).textTheme;
}
