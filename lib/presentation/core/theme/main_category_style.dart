import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/app_colors.dart';

class MainCategoryStyle {
  final String iconAsset;
  final Color surface;
  final Color foreground;

  const MainCategoryStyle._({
    required this.iconAsset,
    required this.surface,
    required this.foreground,
  });

  static MainCategoryStyle of(BuildContext context, String main) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final (icon, light, dark) = _styles[main] ?? _fallback;
    final (surface, foreground) = isDark ? dark : light;
    return MainCategoryStyle._(
      iconAsset: 'assets/topic/$icon.svg',
      surface: surface,
      foreground: foreground,
    );
  }

  static const _blue = (AppColors.mainBlueSurface, AppColors.mainBlue);
  static const _darkBlue = (
    AppColors.darkMainBlueSurface,
    AppColors.darkMainBlue,
  );

  static const _fallback = ('topic_software_eng', _blue, _darkBlue);

  static const _styles = <String, (String, (Color, Color), (Color, Color))>{
    '자료구조': (
      'topic_data_structure',
      (AppColors.mainGreenSurface, AppColors.mainGreen),
      (AppColors.darkMainGreenSurface, AppColors.darkMainGreen),
    ),
    '알고리즘': (
      'topic_algorithm',
      (AppColors.mainYellowSurface, AppColors.mainYellow),
      (AppColors.darkMainYellowSurface, AppColors.darkMainYellow),
    ),
    '운영체제': (
      'topic_os',
      (AppColors.mainPurpleSurface, AppColors.mainPurple),
      (AppColors.darkMainPurpleSurface, AppColors.darkMainPurple),
    ),
    '네트워크': ('topic_network', _blue, _darkBlue),
    '데이터베이스': (
      'topic_database',
      (AppColors.mainOrangeSurface, AppColors.mainOrange),
      (AppColors.darkMainOrangeSurface, AppColors.darkMainOrange),
    ),
    '컴퓨터 구조': (
      'topic_architecture',
      (AppColors.mainSlateSurface, AppColors.mainSlate),
      (AppColors.darkMainSlateSurface, AppColors.darkMainSlate),
    ),
    '소프트웨어 공학': (
      'topic_software_eng',
      (AppColors.mainPinkSurface, AppColors.mainPink),
      (AppColors.darkMainPinkSurface, AppColors.darkMainPink),
    ),
    '객체지향 프로그래밍': (
      'topic_oop',
      (AppColors.mainLimeSurface, AppColors.mainLime),
      (AppColors.darkMainLimeSurface, AppColors.darkMainLime),
    ),
    '인공지능': (
      'topic_ai',
      (AppColors.mainFuchsiaSurface, AppColors.mainFuchsia),
      (AppColors.darkMainFuchsiaSurface, AppColors.darkMainFuchsia),
    ),
    '보안': (
      'topic_security',
      (AppColors.mainTealSurface, AppColors.mainTeal),
      (AppColors.darkMainTealSurface, AppColors.darkMainTeal),
    ),
  };
}
