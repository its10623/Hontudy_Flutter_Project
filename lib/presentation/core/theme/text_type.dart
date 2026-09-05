import 'package:flutter/material.dart';

class TextType {
  TextType._();

  /// 28sp / w700 — 가장 큰 타이틀(예: 스플래시, 온보딩 헤드라인)
  static const displayLarge = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );

  /// 26sp / w600
  static const displaySmall = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 26,
    fontWeight: FontWeight.w600,
  );

  /// 24sp / w700 — 화면 상단 큰 제목
  static const titleLarge = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  /// 20sp / w700
  static const titleMedium = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  /// 18sp / w600
  static const titleSmall = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  /// 17sp / w600 — 섹션 헤드라인
  static const headlineLarge = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );

  /// 16sp / w600
  static const headlineSmall = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  /// 15sp / w400 — 본문 기본 텍스트
  static const bodyLarge = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  /// 14sp / w400 — 본문 보조 텍스트
  static const bodySmall = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  /// 13sp / w500 — 버튼/칩 등 라벨
  static const labelLarge = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  /// 12sp / w500 — 작은 라벨(뱃지 등)
  static const labelSmall = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  /// 13sp / w400 — 캡션 중 가장 큰 사이즈
  static const captionLarge = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  /// 12sp / w400 — 기본 캡션
  static const captionMedium = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  /// 11sp / w400 — 가장 작은 캡션(타임스탬프 등)
  static const captionSmall = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );
}
