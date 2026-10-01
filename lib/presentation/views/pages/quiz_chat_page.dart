import 'package:flutter/material.dart';

import '../../core/theme/context_theme_extension.dart';
import '../component/chat/chat_appbar.dart';
import '../component/chat/chat_body.dart';

class QuizChatPage extends StatefulWidget {
  const QuizChatPage({super.key});

  @override
  QuizChatPageState createState() => QuizChatPageState();
}

class QuizChatPageState extends State<QuizChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppbar(
        pageInfo: '문제풀이 · 네트워크',
        currentState: '난이도 중',
        onNote: _navigateWidget(
          Icons.menu_book_outlined,
          onTap: () {
            /// TODO 노트 페이지 이동
          },
        ),
        onProfile: _navigateWidget(
          Icons.person_outline_rounded,
          onTap: () {
            /// TODO 프로필 스크린 이동
          },
        ),
      ),
      body: const ChatBody(
        metadata: '3일전에 풀었던 문제입니다',
        isMetadata: true,
      ),
    );
  }

  Widget _navigateWidget(IconData icon, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: context.colors.surfaceContainerHighest.withAlpha(30),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: context.colors.primary,
        ),
      ),
    );
  }
}
