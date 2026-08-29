import 'package:flutter/material.dart';
import 'package:flutter_gen_ai_chat_ui/flutter_gen_ai_chat_ui.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';

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
  final _currentUser = ChatUser(id: 'user', firstName: 'User');
  final _aiUser = ChatUser(id: 'ai', firstName: '혼터디 AI');
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint(
          '[SCROLL DEBUG] hasClients=${_scrollController.hasClients}, '
          'positions=${_scrollController.positions.length}');
      if (!_scrollController.hasClients) return;
      debugPrint(
          '[SCROLL DEBUG] maxScrollExtent=${_scrollController.position.maxScrollExtent}, '
          'pixels=${_scrollController.position.pixels}');
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
        onSendMessage: _handleSendMessage,
        messageOptions: MessageOptions(
          showUserName: false,
          showTime: false,
          bubbleBuilder: (context, message, isCurrentUser, defaultBubble) =>
              Column(
                crossAxisAlignment: isCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (widget.isMetadata) ...[
                    if (!isCurrentUser) ...[
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.access_time_rounded),
                            Text(widget.metadata!),
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
                              image: DecorationImage(
                                image: const AssetImage(
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
        ),
        messageListOptions: MessageListOptions(
          paginationConfig: _pagination,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        ),
        scrollBehaviorConfig: ScrollBehaviorConfig(
          autoScrollBehavior: AutoScrollBehavior.always,
        ),
        scrollToBottomOptions: ScrollToBottomOptions(
          bottomOffset: 10
        ),


        loadingConfig: LoadingConfig(isLoading: _isLoading),
        inputOptions: InputOptions(
          materialColor: Colors.transparent,
          materialElevation: 0,
          containerDecoration: BoxDecoration(
            color: context.colors.surface,
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
              icon: Icon(Icons.mic_none),
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
                  child: Icon(Icons.send, color: context.colors.onPrimary),
                ),
              ),
            ),
          ),
        ),
        welcomeMessageConfig: WelcomeMessageConfig(
          title: '혼터디에 오신 것을 환영 합니다\n어떤 공부를 하고 싶으신가요?',
          questionsSectionTitle: '카드를 선택해주세요',
        ),
        exampleQuestions: [
          ExampleQuestion(question: "언어 공부 하고 싶습니다"),
          ExampleQuestion(question: "CS 공부하고 싶습니다"),
        ],
      ),
    );
  }

  void _handleMicTap() {
    // TODO: speech_to_text 연동 예정. 인식 결과는 즉시 전송하지 않고
    // 입력창 텍스트만 채워서 사용자가 확인/수정 후 직접 전송
  }

  Future<void> _handleSendMessage(ChatMessage message) async {
    _controller.addMessage(message);
    _scrollToBottom();
    setState(() => _isLoading = true);

    try {
      // Your AI service logic here
      await Future.delayed(Duration(seconds: 1)); // Simulating API call

      // Add AI response
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
}
