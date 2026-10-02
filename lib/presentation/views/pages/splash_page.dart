import 'package:flutter/material.dart';
import 'package:hontudy/domain/use_cases/determine_next_route_use_case.dart';
import 'package:hontudy/presentation/viewmodels/splash_viewmodel.dart';
import 'package:hontudy/presentation/views/component/error_dialog.dart';
import 'package:hontudy/presentation/views/pages/diagnosis_chat_page.dart';
import 'package:hontudy/presentation/views/pages/quiz_chat_page.dart';
import 'package:hontudy/presentation/views/pages/sign_in_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/context_theme_extension.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<NextRoute>>(splashViewModelProvider, (
      previous,
      next,
    ) {
      next.whenData((route) {
        final Widget page = switch (route) {
          NextRoute.needsSignIn ||
          NextRoute.needsTermsAgreement => const SignInPage(),
          NextRoute.needDiagnosis => const DiagnosisChatPage(),
          NextRoute.ready => const QuizChatPage(),
        };
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => page),
        );
      });
      if (next is AsyncError) {
        ErrorDialog.show(
          context: context,
          error: next.error!,
          buttonText: '다시 시도',
          barrierDismissible: false,
          onPressed: () => ref.invalidate(splashViewModelProvider),
        );
      }
    });
    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 800),
        builder: (context, opacity, child) =>
            Opacity(opacity: opacity, child: child),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              width: 200,
              child: Image.asset('assets/icons/hontudy_icon.png'),
            ),
            Text(
              "혼터디",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: context.colors.onSurface,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "문제를 풀며 IT지식을 쌓아가요",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: context.colors.primary,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
