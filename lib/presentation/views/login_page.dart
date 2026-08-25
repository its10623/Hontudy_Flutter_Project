import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/text_type_extension.dart';
import '../core/theme/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
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
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/hontudy_icon.png'),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '혼터디',
                      style: textTheme.displayLarge?.copyWith(
                        color: colorTheme.primary,
                      ),
                    ),
                    TextSpan(
                      text: '와 함께',
                      style: textTheme.displayLarge,
                    ),
                  ],
                ),
              ),
              Text(
                '지식을 쌓아보세요',
                style: textTheme.displayLarge,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 12),
              Text(
                '매일 몇 개의 문제로 실력을 확인하고,',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorTheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                '풀었던 문제는 노트에 차곡차곡 쌓여요',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorTheme.onSurfaceVariant,
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
