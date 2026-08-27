import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import '../../core/theme/context_theme_extension.dart';
import '../../core/theme/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

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
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: GoogleAuthButton(
                  onPressed: () {},
                  text: 'Google로 계속하기',
                  style: AppTheme.googleAuthButtonStyle(isDarkMode),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: AppleAuthButton(
                  onPressed: () {},
                  text: 'Apple로 계속하기',
                  style: AppTheme.appleAuthButtonStyle(isDarkMode),
                ),
              ),
              Center(
                child: Text(
                  '계속하면 이용약관 및 개인정보처리방침에 동의합니다',
                  style: context.captionSmall.copyWith(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
