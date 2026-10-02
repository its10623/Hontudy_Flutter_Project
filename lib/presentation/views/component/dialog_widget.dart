import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/views/component/primary_button.dart';

class DialogWidget extends StatefulWidget {
  final String title;
  final String? content;
  final String? secondaryText;
  final VoidCallback? secondaryOnPressed;
  final VoidCallback primaryOnPressed;
  final String primaryText;

  const DialogWidget({
    super.key,
    required this.title,
    this.content,
    this.secondaryText,
    required this.primaryText,
    this.secondaryOnPressed,
    required this.primaryOnPressed,
  });

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colors.surface,
      title: Text(
        widget.title,
        style: TextType.headlineSmall.copyWith(fontWeight: FontWeight.w700),
      ),
      content: widget.content != null
          ? Text(
              widget.content!,
              style: context.captionLarge,
            )
          : null,
      actions: [
        Row(
          children: [
            if (widget.secondaryText != null) ...[
              Expanded(
                child: PrimaryButton(
                  onPressed: () {},
                  text: widget.secondaryText!,
                  color: ButtonColor.surface,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
            Expanded(
              child: PrimaryButton(
                onPressed: () {},
                text: widget.primaryText,
                color: ButtonColor.primary,
              ),
            ),
          ],
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
