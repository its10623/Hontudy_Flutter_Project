import 'package:flutter/material.dart';

import '../../../core/theme/context_theme_extension.dart';
import '../../../core/theme/shape.dart';

class ChatInputBar extends StatefulWidget {
  final ValueChanged<String> onSend;
  final VoidCallback onMicTap;
  final bool enabled;
  final String hintText;

  const ChatInputBar({
    super.key,
    required this.onSend,
    required this.onMicTap,
    this.enabled = true,
    this.hintText = '답변을 입력해주세요',
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _send() {
    final text = _textController.text.trim();
    if (!widget.enabled || text.isEmpty) return;
    widget.onSend(text);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: AppShape.pill,
        boxShadow: [
          BoxShadow(
            color: context.colors.onSurface.withAlpha(26),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              enabled: widget.enabled,
              minLines: 1,
              maxLines: 5,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _send(),
              style: context.textStyles.bodyLarge,
              decoration: InputDecoration(
                isDense: true,
                filled: false,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.fromLTRB(18, 12, 0, 12),
                hintText: widget.hintText,
                hintStyle: context.textStyles.bodyLarge?.copyWith(
                  color: context.captionSmall.color?.withValues(alpha: 0.2),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mic_none),
            onPressed: widget.enabled ? widget.onMicTap : null,
          ),
          const SizedBox(width: 4),
          _SendButton(onTap: widget.enabled ? _send : null),
        ],
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _SendButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = onTap != null
        ? context.colors.primary
        : context.colors.primary.withAlpha(100);
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(77),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: color,
        child: InkWell(
          onTap: onTap,
          child: Icon(Icons.send_rounded, color: context.colors.onPrimary),
        ),
      ),
    );
  }
}
