import 'package:flutter/material.dart';

class AppShape {
  AppShape._();

  /// 20 — 화면 최상위 카드
  static const card = BorderRadius.all(Radius.circular(20));

  /// 16 — GenUI 위젯 카드, 요약 카드
  static const widgetCard = BorderRadius.all(Radius.circular(16));

  /// 14 — 선택 옵션 아이템, 하단 고정 버튼
  static const option = BorderRadius.all(Radius.circular(14));

  /// 12 — 카드 내부 버튼, 스켈레톤 블록
  static const button = BorderRadius.all(Radius.circular(12));

  /// 10 — 세그먼트 버튼, 힌트,정답 보기 버튼
  static const segment = BorderRadius.all(Radius.circular(10));

  /// 8 — 카테고리 라벨 배지, 스켈레톤
  static const badge = BorderRadius.all(Radius.circular(8));

  /// 6 — 스켈레톤 텍스트 바
  static const skeletonBar = BorderRadius.all(Radius.circular(6));

  /// 100 — 원형
  static const pill = BorderRadius.all(Radius.circular(100));

  /// 24 — 플로팅 하단 탭바
  static const floating = BorderRadius.all(Radius.circular(24));

  /// 24 상단만 — 바텀시트
  static const sheetTop = BorderRadius.vertical(top: Radius.circular(24));

  /// 채팅 말풍선
  static const aiBubble = BorderRadius.only(
    topLeft: Radius.circular(22),
    topRight: Radius.circular(22),
    bottomRight: Radius.circular(22),
    bottomLeft: Radius.circular(8),
  );

  static const userBubble = BorderRadius.only(
    topLeft: Radius.circular(22),
    topRight: Radius.circular(22),
    bottomLeft: Radius.circular(22),
    bottomRight: Radius.circular(8),
  );
}
