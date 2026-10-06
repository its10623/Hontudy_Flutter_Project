import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';

class ChoiceChipItem extends StatelessWidget {
  final Widget label;
  final Widget? avatar;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const ChoiceChipItem({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      avatar: avatar,
      label: label,
      showCheckmark: false,
      shape: const RoundedRectangleBorder(borderRadius: AppShape.pill),
      labelStyle: TextType.captionLarge.copyWith(fontWeight: FontWeight.w800),
      selected: isSelected,
      onSelected: onSelected,
    );
  }
}
