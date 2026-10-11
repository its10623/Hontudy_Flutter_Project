import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';

class PrimaryButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final String text;
  final ButtonColor color;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
    this.icon,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: widget.onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: _backgroundColor(context),
        foregroundColor: _foregroundColor(context),
        shape: const RoundedRectangleBorder(
          borderRadius: AppShape.widgetCard,
        ),
        minimumSize: const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        side: widget.color != ButtonColor.primary
            ? BorderSide(width: 1, color: context.colors.outline.withAlpha(50))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.icon != null) ...[
            Icon(
              widget.icon,
              size: 20,
            ),
            const SizedBox(width: 4),
          ],
          // 다이얼로그처럼 폭이 좁은 곳에서는 넘치지 않고 글자가 줄어들게 함
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.text,
                maxLines: 1,
                style: TextType.bodyLarge.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color? _backgroundColor(BuildContext context) {
    switch (widget.color) {
      case ButtonColor.primary:
        return context.colors.primary;
      case ButtonColor.surface:
        return context.colors.surface;
    }
  }

  Color _foregroundColor(BuildContext context) {
    switch (widget.color) {
      case ButtonColor.primary:
        return context.colors.onPrimary;
      case ButtonColor.surface:
        return context.colors.onSurface;
    }
  }
}

enum ButtonColor { primary, surface }
