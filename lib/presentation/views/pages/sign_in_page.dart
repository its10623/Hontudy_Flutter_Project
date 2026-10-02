import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hontudy/presentation/viewmodels/sign_in_viewmodel.dart';
import 'package:hontudy/presentation/views/component/terms_agreement_sheet.dart';
import 'package:hontudy/presentation/views/pages/quiz_chat_page.dart';
import '../../../domain/models/user.dart';
import '../../../domain/use_cases/determine_next_route_use_case.dart';
import '../../core/theme/context_theme_extension.dart';
import '../../core/theme/theme.dart';
import '../component/error_dialog.dart';
import 'diagnosis_chat_page.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  AuthProvider? _pressed;

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(signInViewModelProvider).isLoading;
    ref.listen<AsyncValue<NextRoute?>>(
      signInViewModelProvider,
      (
        previous,
        next,
      ) {
        next.whenData((route) async {
          final Widget page;
          switch (route) {
            case NextRoute.needsSignIn || null:
              return;
            case NextRoute.needsTermsAgreement:
              final agreed = await showTermsAgreementSheet(context);
              if (!context.mounted) return;
              if (agreed) {
                await ref.read(signInViewModelProvider.notifier).agreeToTerms();
              } else {
                await ref
                    .read(signInViewModelProvider.notifier)
                    .disagreeToTerms();
              }
              return;
            case NextRoute.needDiagnosis:
              page = const DiagnosisChatPage();
            case NextRoute.ready:
              page = const QuizChatPage();
          }
          if (!context.mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => page),
          );
        });
        if (next is AsyncError) {
          ErrorDialog.show(
            context: context,
            error: next.error!,
          );
        }
      },
    );
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/hontudy_icon.png'),
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '혼터디',
                      style: context.textStyles.displayLarge?.copyWith(
                        color: context.colors.primary,
                      ),
                    ),
                    TextSpan(
                      text: '와 함께',
                      style: context.textStyles.displayLarge,
                    ),
                  ],
                ),
              ),
              Text(
                '지식을 쌓아보세요',
                style: context.textStyles.displayLarge,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 12),
              Text(
                '매일 몇 개의 문제로 실력을 확인하고,',
                style: context.textStyles.bodyLarge?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                '풀었던 문제는 노트에 차곡차곡 쌓여요',
                style: context.textStyles.bodyLarge?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
                textAlign: TextAlign.left,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: GoogleAuthButton(
                  isLoading: isLoading && _pressed == AuthProvider.google,
                  onPressed: isLoading
                      ? null
                      : () {
                          setState(() {
                            _pressed = AuthProvider.google;
                          });
                          ref
                              .read(signInViewModelProvider.notifier)
                              .signIn(AuthProvider.google);
                        },
                  text: 'Google로 계속하기',
                  style: AppTheme.googleAuthButtonStyle(isDarkMode),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: AppleAuthButton(
                  isLoading: isLoading && _pressed == AuthProvider.apple,
                  onPressed: isLoading
                      ? null
                      : () {
                          setState(() {
                            _pressed = AuthProvider.apple;
                          });
                          ref
                              .read(signInViewModelProvider.notifier)
                              .signIn(AuthProvider.apple);
                        },
                  text: 'Apple로 계속하기',
                  style: AppTheme.appleAuthButtonStyle(isDarkMode),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
