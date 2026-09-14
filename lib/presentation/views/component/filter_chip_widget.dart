import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/app_colors.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';

class FilterChipWidget extends StatefulWidget {
  final Function(bool) onSelected;
  final bool isSelected;
  final Widget label;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.onSelected,
    required this.isSelected,
  });

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: widget.isSelected,
      selectedColor: context.colors.primary,
      side: WidgetStateBorderSide.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return BorderSide(color: context.colors.primary, width: 1.0);
        } else {
          return null;
        }
      }),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
      label: widget.label,
      onSelected: widget.onSelected,
      showCheckmark: false,
      labelStyle: widget.isSelected
          ? TextType.captionLarge.copyWith(
              color: context.colors.onPrimary,
              fontWeight: FontWeight.w800,
            )
          : TextType.captionLarge.copyWith(fontWeight: FontWeight.w800),
    );
  }
}
