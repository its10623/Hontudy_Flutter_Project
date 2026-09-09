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
        ),
        messageListOptions: MessageListOptions(
          paginationConfig: _pagination,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        ),
        scrollBehaviorConfig: ScrollBehaviorConfig(
          autoScrollBehavior: AutoScrollBehavior.always,
        ),
        scrollToBottomOptions: ScrollToBottomOptions(bottomOffset: 10),

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
