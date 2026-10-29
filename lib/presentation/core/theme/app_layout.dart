
import 'package:flutter/material.dart';

class AppLayout {
  AppLayout._();

  /// 600 - 이 폭 부터는 NavigationRail
  static const double railBreakpoint = 600;
  /// 840 - 웹 컨텐츠 최대 폭
  static const double maxContentWidth = 840;
  /// 580 - 웹 컨텐츠 버블 최대폭
  static const double wideBubbleMaxWidth = 580;
  /// 240 - 레일 가로 폭
  static const double railWidth = 240;

  static bool isWide(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= railBreakpoint;
  }
}