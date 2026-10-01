import 'package:flutter/material.dart';
import 'package:flutter_gen_ai_chat_ui/flutter_gen_ai_chat_ui.dart';
import 'package:hontudy/presentation/core/theme/app_colors.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/views/component/chat/mic_bottom_sheet.dart';
import 'package:hontudy/presentation/views/component/genui/answer_feeback.dart';
import 'package:hontudy/presentation/views/component/genui/code_block.dart';
import 'package:hontudy/presentation/views/component/genui/diagnosis_choice_chip.dart';
import 'package:hontudy/presentation/views/component/genui/image_widget.dart';
import 'package:hontudy/presentation/views/component/genui/quiz_choice_chip.dart';
import 'package:hontudy/presentation/views/component/genui/summary_confirm.dart';
import 'package:hontudy/presentation/views/component/shimmer_wrapper.dart';

import '../skeleton_box.dart';
import '../genui/filter_chip_gen_ui.dart';

class ChatBody extends StatefulWidget {
  final bool isMetadata;
  final String? metadata;

  const ChatBody({
    super.key,
    this.metadata,
    required this.isMetadata,
  });

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  static const _pagination = PaginationConfig(reverseOrder: false);
  final _controller = ChatMessagesController(
    paginationConfig: _pagination,
  );
  final _scrollController = ScrollController();
  final _textController = TextEditingController();
  static const _currentUser = ChatUser(id: 'user', firstName: 'User');
  static const _aiUser = ChatUser(id: 'ai', firstName: '혼터디 AI');
  bool _isLoading = false;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: AiChatWidget(
        currentUser: _currentUser,
        aiUser: _currentUser,
        controller: _controller,
        scrollController: _scrollController,
        onSendMessage: _onSendMessage,
        //_handleSendMessage,
        messageOptions: _messageOptions(),
        messageListOptions: const MessageListOptions(
          paginationConfig: _pagination,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        ),
        scrollBehaviorConfig: const ScrollBehaviorConfig(
          autoScrollBehavior: AutoScrollBehavior.always,
        ),
        scrollToBottomOptions: const ScrollToBottomOptions(bottomOffset: 10),
        loadingConfig: LoadingConfig(isLoading: _isLoading),
        inputOptions: _inputOptions(),
        welcomeMessageConfig: const WelcomeMessageConfig(
          title: '혼터디에 오신 것을 환영 합니다\n어떤 공부를 하고 싶으신가요?',
          questionsSectionTitle: '카드를 선택해주세요',
        ),
        exampleQuestions: const [
          ExampleQuestion(question: "언어 공부 하고 싶습니다"),
          ExampleQuestion(question: "CS 공부하고 싶습니다"),
        ],
        resultRenderers: {
          'choice_chips': (context, data) => FilterChipGenUi(data: data),
          'single_choice_list': (context, data) =>
              DiagnosisChoiceChip(data: data),
          'summary_confirm': (context, data) => SummaryConfirm(
            data: data,
            isChecked: _isChecked,
            onChanged: (value) {
              setState(() {
                _isChecked = value ?? false;
              });
            },
          ),
          'single_choice_question': (context, data) => QuizChoiceChip(
            data: data,
          ),
          'image_diagram': (context, data) => ImageWidget(
            data: data,
          ),
          'code_block': (context, data) => CodeBlock(data: data),
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
              borderRadius: const BorderRadius.all(Radius.circular(16)),
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
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SkeletonBox(
                    width: 200,
                    height: 20,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
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
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      SkeletonBox(
                        width: 80,
                        height: 30,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      SkeletonBox(
                        width: 80,
                        height: 30,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      SkeletonBox(
                        width: 80,
                        height: 30,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      SkeletonBox(
                        width: 80,
                        height: 30,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        },
      ),
    );
  }

  Future<void> _handleMicTap() async {
    await showModalBottomSheet(
      context: context,
      builder: (_) => const MicBottomSheet(),
    );
  }

  Future<void> _handleSendMessage(ChatMessage message) async {
    _controller.addMessage(message);
    _scrollToBottom();
    setState(() => _isLoading = true);
    //_controller.addMessage(ChatMessage.loading(user: _aiUser, id: id))

    try {
      await Future.delayed(const Duration(seconds: 1));

      _controller.addMessage(
        ChatMessage(
          text: "This is a response to: ${message.text}",
          user: _aiUser,
          createdAt: DateTime.now(),
        ),
      );
      _scrollToBottom();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onSendMessage(ChatMessage message) async {
    _controller.addMessage(message);
    _scrollToBottom();
    final id = 'genui-${DateTime.now().microsecondsSinceEpoch}';

    _controller.addMessage(
      ChatMessage.loading(
        user: _aiUser,
        id: id,
        loadingKind: 'genui_loading',
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    final mockCatalog = <(String, Map<String, dynamic>)>[
      (
        'choice_chips',
        {
          'prompt': '좋아요. 그럼 아래 중에서 지금 가장 자신 없는 영역을 골라주세요. 여러 개도 괜찮습니다.',
          'options': ['네트워크', '알고리즘', '자료구조', '데이터베이스'],
        },
      ),
      (
        'summary_confirm',
        {
          'prompt': '정리해보면 이렇습니다. 맞으면 그대로 시작할게요.',
          'options': ['비전공자', '2/5', '취업·이직 준비', '운영체제, 네트워크'],
        },
      ),
      (
        'single_choice_list',
        {
          'prompt': '지금 목표에 가장 가까운 하나를 골라주세요.',
          'options': ['취업 준비', '이직 준비', '학점/시험 대비', '실무 역량 강화'],
        },
      ),
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
        user: _aiUser,
        id: id,
        resultKind: picked.$1,
        data: picked.$2,
      ),
    );
  }

  // 채팅 버블내 메세지 옵션
  MessageOptions _messageOptions() {
    return MessageOptions(
      containerColor: context.colors.surfaceContainerLowest,
      showUserName: false,
      showTime: false,
      bubbleBuilder: (context, message, isCurrentUser, defaultBubble) => Column(
        crossAxisAlignment: isCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (widget.isMetadata) ...[
            if (!isCurrentUser) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  color: AppColors.metadata,
                  borderRadius: BorderRadius.circular(99),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 18,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      widget.metadata!,
                      style: context.textStyles.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ],
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 4,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isCurrentUser) ...[
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: context.colors.primaryContainer.withAlpha(
                        200,
                      ),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/icons/ai_icon.png',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  message.user.name,
                  style: context.textStyles.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          defaultBubble,
        ],
      ),
    );
  }

  // 사용자 채팅창 입력 옵션
  InputOptions _inputOptions() {
    return InputOptions(
      textController: _textController,
      materialColor: Colors.transparent,
      materialElevation: 0,
      containerDecoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.colors.surfaceContainerHighest.withValues(
              alpha: 0.8,
            ),
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      containerPadding: const EdgeInsets.all(8),
      decoration: InputDecoration(
        filled: true,
        fillColor: context.colors.surfaceContainerHighest.withAlpha(30),
        hintText: '답변을 입력해주세요..',
        hintStyle: context.textStyles.bodyLarge?.copyWith(
          color: context.captionSmall.color?.withValues(alpha: 0.2),
        ),
        helperText: '다른 공부 고민이 있다면 자유롭게 말해주세요',
        helperStyle: context.captionSmall.copyWith(
          color: context.captionSmall.color?.withValues(alpha: 0.6),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.mic_none),
          onPressed: _handleMicTap,
        ),
      ),
      sendOnEnter: true,
      sendButtonColor: context.colors.primary,
      sendButtonBuilder: (onSend) => Transform.translate(
        offset: const Offset(0, -12),
        child: SizedBox(
          width: 50,
          height: 50,
          child: Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            color: context.colors.primary,
            child: InkWell(
              onTap: onSend,
              child: Icon(Icons.send_rounded, color: context.colors.onPrimary),
            ),
          ),
        ),
      ),
    );
  }
}
