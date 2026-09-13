import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';

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
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      label: Text(
        widget.label,
        style: TextType.captionMedium.copyWith(
          color: widget.textColor ?? context.colors.primary,
          fontWeight: FontWeight.w800,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
      side: BorderSide.none,
      backgroundColor: widget.backgroundColor ?? context.colors.primaryContainer.withAlpha(150),
      padding: EdgeInsets.symmetric(horizontal: 8,),
    );
  }
}
