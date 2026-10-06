import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';

class ChipWidget extends StatefulWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;

  const ChipWidget({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
  });

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color:
            widget.backgroundColor ??
            context.colors.primaryContainer.withAlpha(150),
        borderRadius: AppShape.pill,
      ),
      child: Text(
        widget.label,
        style: TextType.captionMedium.copyWith(
          color: widget.textColor ?? context.colors.primary,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
