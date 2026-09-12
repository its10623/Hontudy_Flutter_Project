import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';

class TopicChip extends StatefulWidget {
  final String label;

  const TopicChip({
    super.key,
    required this.label,
  });

  @override
  State<TopicChip> createState() => _TopicChipState();
}

class _TopicChipState extends State<TopicChip> {
  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      label: Text(
        widget.label,
        style: TextType.captionMedium.copyWith(color: context.colors.primary, fontWeight: FontWeight.w800)
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
      backgroundColor: context.colors.primaryContainer.withAlpha(150),
      padding: EdgeInsets.symmetric(horizontal: 8,),
    );
  }
}
