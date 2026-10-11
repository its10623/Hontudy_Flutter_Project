import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hontudy/domain/models/diagnosis_profile.dart';
import 'package:hontudy/presentation/views/pages/all_mains_page.dart';
import 'package:hontudy/presentation/views/pages/diagnosis_chat_page.dart';
import 'package:hontudy/presentation/views/pages/note_detail_page.dart';
import 'package:hontudy/presentation/views/pages/note_summary_page.dart';
import 'package:hontudy/presentation/views/pages/profile_page.dart';
import 'package:hontudy/presentation/views/pages/quiz_chat_page.dart';
import 'package:hontudy/presentation/views/pages/sign_in_page.dart';
import 'package:hontudy/presentation/views/pages/splash_page.dart';

import 'bottom_nav_bar.dart';
import 'exit_guard.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const signIn = '/sign-in';
  static const diagnosis = '/diagnosis';
  static const home = '/home';
  static const note = '/note';
  static const noteAll = '/note/all';
  static const noteWrong = '/note/wrong';
  static const profile = '/profile';

  static String noteDetail(String main, {String? qid}) => Uri(
    path: '/note/detail/$main',
    queryParameters: qid == null ? null : {'qid': qid},
  ).toString();
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (_, _) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      builder: (_, _) => const SignInPage(),
    ),
    GoRoute(
      path: AppRoutes.diagnosis,
      builder: (_, _) => const ExitGuard(child: DiagnosisChatPage()),
    ),
    StatefulShellRoute.indexedStack(
      builder: (_, _, navigationShell) =>
          _TabShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (_, state) =>
                  QuizChatPage(profile: state.extra as DiagnosisProfile?),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.note,
              builder: (_, _) => const NoteSummaryPage(),
              routes: [
                GoRoute(
                  path: 'all',
                  builder: (_, _) => const AllMainsPage(),
                ),
                GoRoute(
                  path: 'wrong',
                  builder: (_, _) => const NoteDetailPage(
                    main: null,
                    initialFilter: NoteRecordFilter.wrong,
                  ),
                ),
                GoRoute(
                  path: 'detail/:main',
                  builder: (_, state) => NoteDetailPage(
                    main: state.pathParameters['main']!,
                    initialQid: state.uri.queryParameters['qid'],
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (_, _) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class _TabShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const _TabShell({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return ExitGuard(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: navigationShell,
        // 문제풀이(홈) 탭은 몰입을 위해 탭을 숨기고 헤더 버튼으로 이동
        bottomNavigationBar: navigationShell.currentIndex == 0
            ? null
            : SafeArea(
                child: BottomNavBar(
                  currentIndex: navigationShell.currentIndex,
                  onTap: (index) => navigationShell.goBranch(
                    index,
                    initialLocation: index == navigationShell.currentIndex,
                  ),
                ),
              ),
      ),
    );
  }
}
