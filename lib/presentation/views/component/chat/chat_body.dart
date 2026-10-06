import 'package:flutter/material.dart';
import 'package:flutter_gen_ai_chat_ui/flutter_gen_ai_chat_ui.dart';
import 'package:hontudy/presentation/core/theme/app_colors.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';
import 'package:hontudy/presentation/views/component/chat/chat_bubble.dart';
import 'package:hontudy/presentation/views/component/chat/chat_input_bar.dart';
import 'package:hontudy/presentation/views/component/chat/mic_bottom_sheet.dart';

const chatCurrentUser = ChatUser(id: 'user', firstName: 'User');
const chatAiUser = ChatUser(id: 'ai', firstName: '혼터디 AI');

typedef ChatFooterBuilder =
    Widget? Function(BuildContext context, ChatMessage message);

class ChatBody extends StatefulWidget {
  final ChatMessagesController controller;
  final ValueChanged<String> onSend;
  final bool inputEnabled;
  final ChatFooterBuilder? footerBuilder;
  final String? metadata;
  final Map<String, ResultBuilder> resultRenderers;
  final Map<String, ResultBuilder> resultLoadingRenderers;

  const ChatBody({
    super.key,
    required this.controller,
    required this.onSend,
    this.inputEnabled = true,
    this.footerBuilder,
    this.metadata,
    this.resultRenderers = const {},
    this.resultLoadingRenderers = const {},
  });

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  static const _pagination = PaginationConfig(reverseOrder: false);
  static const _inputBottomMargin = 16.0;
  static const _messageGap = 8.0;
  static const _inputBarHeight = 66.0;
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double get _listBottomInset =>
      _inputBarHeight +
      MediaQuery.paddingOf(context).bottom +
      _inputBottomMargin +
      _messageGap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Positioned.fill(child: _buildChatList()),
          Positioned(
            left: 16,
            right: 16,
            bottom: _inputBottomMargin,
            child: SafeArea(
              top: false,
              child: ChatInputBar(
                enabled: widget.inputEnabled,
                onSend: widget.onSend,
                onMicTap: _handleMicTap,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return AiChatWidget(
      readOnly: true,
      spacingConfig: ChatSpacingConfig(
        messageListPadding: EdgeInsets.fromLTRB(16, 8, 16, _listBottomInset),
      ),
      currentUser: chatCurrentUser,
      aiUser: chatAiUser,
      controller: widget.controller,
      scrollController: _scrollController,
      onSendMessage: (message) => widget.onSend(message.text),
      messageOptions: _messageOptions(),
      messageListOptions: const MessageListOptions(
        paginationConfig: _pagination,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
      ),
      scrollBehaviorConfig: const ScrollBehaviorConfig(
        autoScrollBehavior: AutoScrollBehavior.always,
      ),
      scrollToBottomOptions: ScrollToBottomOptions(
        bottomOffset: _listBottomInset,
      ),
      resultRenderers: widget.resultRenderers,
      resultLoadingRenderers: widget.resultLoadingRenderers,
    );
  }

  Future<void> _handleMicTap() async {
    await showModalBottomSheet(
      context: context,
      builder: (_) => const MicBottomSheet(),
    );
  }

  MessageOptions _messageOptions() {
    return MessageOptions(
      showUserName: false,
      showTime: false,
      customBubbleBuilder: (context, message, isCurrentUser) {
        if (isCurrentUser) {
          return UserChatBubble(
            text: message.text,
            createdAt: message.createdAt,
          );
        }
        return AiChatBubble(
          name: message.user.name,
          text: message.text,
          createdAt: message.createdAt,
          header: widget.metadata != null ? _metadataBadge() : null,
          footer: widget.footerBuilder?.call(context, message),
        );
      },
    );
  }

  Widget _metadataBadge() {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: const BoxDecoration(
        color: AppColors.metadata,
        borderRadius: AppShape.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.access_time_rounded, size: 18),
          const SizedBox(width: 2),
          Text(widget.metadata!, style: context.textStyles.labelSmall),
        ],
      ),
    );
  }
}
