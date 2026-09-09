import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/app_colors.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';

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
      selectedColor: context.colors.primaryContainer.withAlpha(150),
      side: WidgetStateBorderSide.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const BorderSide(color: AppColors.primary, width: 1.0);
        } else {
          return null;
        }
      }),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
      label: widget.label,
      onSelected: widget.onSelected,
      showCheckmark: false,
      labelStyle: widget.isSelected ? TextStyle(color: context.colors.primary,fontWeight: FontWeight.w800) : null
    );
  }
}
