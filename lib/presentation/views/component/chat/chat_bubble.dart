import 'package:flutter/material.dart';

import '../../../core/theme/context_theme_extension.dart';
import '../../../core/theme/shape.dart';
import 'mascot_avatar.dart';

const _bubblePadding = EdgeInsets.symmetric(horizontal: 15, vertical: 13);
const _itemSpacing = EdgeInsets.only(bottom: 14);

String formatChatTime(DateTime time) {
  final period = time.hour < 12 ? '오전' : '오후';
  final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
  final minute = time.minute.toString().padLeft(2, '0');
  return '$period $hour:$minute';
}

class AiChatBubble extends StatelessWidget {
  final String name;
  final String text;
  final DateTime createdAt;
  final Widget? header;
  final Widget? footer;

  const AiChatBubble({
    super.key,
    required this.name,
    required this.text,
    required this.createdAt,
    this.header,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _itemSpacing,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 354),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MascotAvatar(),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ?header,
                    Text(
                      name,
                      style: context.textStyles.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: context.colors.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (text.isNotEmpty)
                      Container(
                        padding: _bubblePadding,
                        decoration: BoxDecoration(
                          color: context.colors.surfaceContainerLowest,
                          borderRadius: AppShape.aiBubble,
                          border: Border.all(
                            color: context.colors.primary.withAlpha(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: context.colors.primary.withAlpha(18),
                              blurRadius: 18,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Text(
                          text,
                          style: context.textStyles.bodyLarge?.copyWith(
                            height: 1.6,
                          ),
                        ),
                      ),
                    if (footer case final footer?) ...[
                      const SizedBox(height: 10),
                      footer,
                    ],
                    const SizedBox(height: 6),
                    _ChatTime(createdAt: createdAt),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserChatBubble extends StatelessWidget {
  final String text;
  final DateTime createdAt;

  const UserChatBubble({
    super.key,
    required this.text,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _itemSpacing,
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: _bubblePadding,
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: AppShape.userBubble,
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.primary.withAlpha(61),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Text(
                  text,
                  style: context.textStyles.bodyLarge?.copyWith(
                    height: 1.6,
                    color: context.colors.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              _ChatTime(createdAt: createdAt),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatTime extends StatelessWidget {
  final DateTime createdAt;

  const _ChatTime({required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(formatChatTime(createdAt), style: context.captionSmall),
    );
  }
}
