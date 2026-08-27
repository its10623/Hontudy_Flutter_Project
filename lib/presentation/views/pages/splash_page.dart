
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hontudy/presentation/views/pages/login_page.dart';
import '../../core/theme/context_theme_extension.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      // 추후 백그라운드 작업 구현할 경우 asyncNavigationCallback을 통해 스플래시 백그라운드 작업 최적화
      duration: const Duration(milliseconds: 2000),
      nextScreen: const LoginPage(),
      backgroundColor: context.colors.surface,
      setStateTimer: Duration.zero,
      animationDuration: const Duration(milliseconds: 800),
      childWidget: Center(
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
              style: Theme.of(context).textTheme.displayLarge?.copyWith(color: context.colors.onSurface),
            ),
            SizedBox(height: 10,),
            Text(
              "문제를 풀며 IT지식을 쌓아가요",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: context.colors.primary),
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
