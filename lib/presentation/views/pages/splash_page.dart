import 'package:hontudy/presentation/views/route/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:hontudy/domain/use_cases/determine_next_route_use_case.dart';
import 'package:hontudy/presentation/viewmodels/splash_viewmodel.dart';
import 'package:hontudy/presentation/views/component/error_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hontudy/presentation/core/theme/app_colors.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<NextRoute>>(splashViewModelProvider, (
      previous,
      next,
    ) {
      next.whenData((route) {
        context.go(switch (route) {
          NextRoute.needsSignIn ||
          NextRoute.needsTermsAgreement => AppRoutes.signIn,
          NextRoute.needDiagnosis => AppRoutes.diagnosis,
          NextRoute.ready => AppRoutes.home,
        });
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.splashBackground,
        body: Stack(
          children: [
            const Positioned(
              left: -90,
              top: 90,
              child: _Circle(270, AppColors.splashCircle),
            ),
            const Positioned(
              right: -100,
              bottom: 110,
              child: _Circle(290, AppColors.splashCircle),
            ),
            const Positioned(
              left: 64,
              top: 230,
              child: _Circle(14, AppColors.splashMint),
            ),
            const Positioned(
              right: 72,
              top: 320,
              child: _Circle(10, AppColors.splashPeach),
            ),
            const Positioned(
              left: 98,
              bottom: 250,
              child: _Circle(12, AppColors.splashLavender),
            ),
            const Positioned(
              right: 110,
              bottom: 320,
              child: _Circle(8, AppColors.splashYellow),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/mascot/mascot_white_happy.svg',
                    width: 132,
                    height: 132,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '혼터디',
                    style: TextType.displayLarge.copyWith(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '혼자서도 끝까지 가는\nIT 전공 지식 훈련',
                    textAlign: TextAlign.center,
                    style: TextType.bodyLarge.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1.55,
                      color: AppColors.onPrimary.withAlpha(209),
                    ),
                  ),
                  const SizedBox(height: 54),
                  const _LoadingDots(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  final double size;
  final Color color;

  const _Circle(this.size, this.color);

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

class _LoadingDots extends StatefulWidget {
  const _LoadingDots();

  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _opacity(double t, double delay) {
    final p = (t - delay / 1.2) % 1.0;
    return p < 0.5 ? 1 - p * 1.5 : 0.25 + (p - 0.5) * 1.5;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final delay in [0.0, 0.2, 0.4])
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.5),
              child: Opacity(
                opacity: _opacity(_controller.value, delay).clamp(0.0, 1.0),
                child: const _Circle(8, AppColors.onPrimary),
              ),
            ),
        ],
      ),
    );
  }
}
