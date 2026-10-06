import 'package:flutter/material.dart';
import 'package:flutter_gen_ai_chat_ui/flutter_gen_ai_chat_ui.dart';
import 'package:hontudy/domain/models/diagnosis_profile.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';

import '../../core/theme/context_theme_extension.dart';
import '../component/app_background.dart';
import '../component/chat/chat_appbar.dart';
import '../component/chat/chat_body.dart';
import '../component/genui/answer_feeback.dart';
import '../component/genui/code_block.dart';
import '../component/genui/gen_ui_box.dart';
import '../component/genui/image_widget.dart';
import '../component/genui/quiz_choice_chip.dart';
import '../component/shimmer_wrapper.dart';
import '../component/skeleton_box.dart';

class QuizChatPage extends StatefulWidget {
  final DiagnosisProfile? profile;

  const QuizChatPage({super.key, this.profile});

  @override
  QuizChatPageState createState() => QuizChatPageState();
}

class QuizChatPageState extends State<QuizChatPage> {
  final _controller = ChatMessagesController(
    paginationConfig: const PaginationConfig(reverseOrder: false),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onSendMock(String text) async {
    _controller.addMessage(
      ChatMessage(text: text, user: chatCurrentUser, createdAt: DateTime.now()),
    );
    final id = 'genui-${DateTime.now().microsecondsSinceEpoch}';
    _controller.addMessage(
      ChatMessage.loading(
        user: chatAiUser,
        id: id,
        loadingKind: 'genui_loading',
      ),
    );

    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final mockCatalog = <(String, Map<String, dynamic>)>[
      (
        'single_choice_question',
        {
          'prompt': '다음 중 TCP(Transmission Control Protocol)의 특징으로 올바르지 않은 것은?',
          'options': [
            '연결 지향형 프로토콜로 데이터의 신뢰성을 보장한다.',
            '3-Way Handshake 과정을 통해 통신 전 연결을 설정한다.',
            '수신 확인(ACK) 절차가 없어 UDP보다 전송 속도가 빠르다.', // 정답 (오답인 설명)
            '네트워크 혼잡 상태에 따라 전송량을 조절하는 혼잡 제어 기능이 있다.',
            '수신자의 버퍼 크기에 맞춰 전송 속도를 조절하는 흐름 제어 기능이 있다.',
          ],
        },
      ),
      (
        'image_diagram',
        {
          'caption': 'TCP 통신 과정을 패러디한 클라이언트와 서버 간의 동적 UI 협상 흐름도',
        },
      ),
      (
        'code_block',
        {
          'language': 'dart',
          'code': '''
for (int i = 0; i < 3; i++) {
  print('현재 인덱스: \$i');
}

// 2. 리스트 요소 순회에 직관적인 for-in문
final subjects = ['OS', 'Network', 'DB'];
for (String subject in subjects) {
  print('과목명: \$subject');
}
              ''',
        },
      ),
      (
        'answer_feedback',
        {
          'verdict': 'wrong',
          'verdictNote': '정답은 3번입니다',
          'explanation': 'TCP는 ACK 기반의 수신 확인 절차가 있어 UDP보다 속도가 느립니다.',
          'keyPoint': 'TCP=신뢰성(느림), UDP=속도(비신뢰성)',
        },
      ),
    ];
    final picked = (mockCatalog..shuffle()).first;
    _controller.updateMessage(
      ChatMessage.rich(
        user: chatAiUser,
        id: id,
        resultKind: picked.$1,
        data: picked.$2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
        // TODO(임시): QuizViewModel 연결 전까지 mock 응답
        body: ChatBody(
          controller: _controller,
          onSend: _onSendMock,
          metadata: '3일전에 풀었던 문제입니다',
          resultRenderers: {
            'single_choice_question': (context, data) => QuizChoiceChip(
              data: data,
            ),
            'image_diagram': (context, data) => GenUiBox(
              child: ImageWidget(
                url: data['url'],
              ),
            ),
            'code_block': (context, data) => CodeBlock(
              language: data['language'],
              code: data['code'],
            ),
            'answer_feedback': (context, data) => AnswerFeedback(
              answerResult: data['answerResult'] == 'correct'
                  ? AnswerResult.correct
                  : AnswerResult.wrong,
              wrongAnswerNote: data['wrongAnswer'].toString(),
              explanation: data['explanation'].toString(),
              keyPoint: data['keyPoint'],
            ),
          },
          resultLoadingRenderers: {
            'genui_loading': (context, data) => Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colors.surfaceContainerLowest,
                borderRadius: AppShape.widgetCard,
                border: Border.all(
                  width: 1,
                  color: context.colors.outline.withAlpha(50),
                ),
              ),
              child: const ShimmerWrapper(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonBox(
                      width: 300,
                      height: 20,
                      borderRadius: AppShape.widgetCard,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SkeletonBox(
                      width: 200,
                      height: 20,
                      borderRadius: AppShape.widgetCard,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        SkeletonBox(
                          width: 80,
                          height: 30,
                          borderRadius: AppShape.widgetCard,
                        ),
                        SkeletonBox(
                          width: 80,
                          height: 30,
                          borderRadius: AppShape.widgetCard,
                        ),
                        SkeletonBox(
                          width: 80,
                          height: 30,
                          borderRadius: AppShape.widgetCard,
                        ),
                        SkeletonBox(
                          width: 80,
                          height: 30,
                          borderRadius: AppShape.widgetCard,
                        ),
                        SkeletonBox(
                          width: 80,
                          height: 30,
                          borderRadius: AppShape.widgetCard,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          },
        ),
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
