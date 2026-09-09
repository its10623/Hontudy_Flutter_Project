import 'package:flutter/material.dart';
import 'package:flutter_gen_ai_chat_ui/flutter_gen_ai_chat_ui.dart';
import 'package:hontudy/presentation/core/theme/app_colors.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/views/component/chat/mic_bottom_sheet.dart';
import 'package:hontudy/presentation/views/component/shimmer_wrapper.dart';

import '../skeleton_box.dart';
import 'filter_chip_gen_ui.dart';

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
        welcomeMessageConfig: WelcomeMessageConfig(
          title: '혼터디에 오신 것을 환영 합니다\n어떤 공부를 하고 싶으신가요?',
          questionsSectionTitle: '카드를 선택해주세요',
        ),
        exampleQuestions: [
          ExampleQuestion(question: "언어 공부 하고 싶습니다"),
          ExampleQuestion(question: "CS 공부하고 싶습니다"),
        ],
        resultRenderers: {
          'choice_chip': (context, data) => FilterChipGenUi(data: data),
        },
        resultLoadingRenderers: {
          'genui_loading': (context, data) => Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              border: Border.all(
                width: 1,
                color: context.colors.outline.withAlpha(50),
              ),
            ),
            child: ShimmerWrapper(
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
    // TODO: 음성 인식 연동 예정 (STT 방식 미정). 인식 결과는 즉시 전송하지
    // 않고 입력창 텍스트만 채워서 사용자가 확인/수정 후 직접 전송해야 함.
    await showModalBottomSheet(
      context: context,
      builder: (_) => MicBottomSheet(),
    );
  }

  Future<void> _handleSendMessage(ChatMessage message) async {
    _controller.addMessage(message);
    _scrollToBottom();
    setState(() => _isLoading = true);
    //_controller.addMessage(ChatMessage.loading(user: _aiUser, id: id))

    try {
      await Future.delayed(Duration(seconds: 1));

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
        'choice_chip',
        {
          'prompt': '좋아요. 그럼 아래 중에서 지금 가장 자신 없는 영역을 골라주세요. 여러 개도 괜찮습니다.',
          'options': ['네트워크', '알고리즘', '자료구조', '데이터베이스'],
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
                margin: EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  color: AppColors.metadata,
                  borderRadius: BorderRadius.circular(99),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 18,
                    ),
                    SizedBox(width: 2),
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
    );
  }

  // 사용자 채팅창 입력 옵션
  InputOptions _inputOptions() {
    return InputOptions(
      textController: _textController,
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
              child: Icon(Icons.send_rounded, color: context.colors.onPrimary),
            ),
          ),
        ),
      ),
    );
  }
}
