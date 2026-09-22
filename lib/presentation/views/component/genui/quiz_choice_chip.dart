import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';

import 'gen_ui_box.dart';

class QuizChoiceChip extends StatefulWidget {
  final dynamic data;

  const QuizChoiceChip({super.key, this.data});

  @override
  State<QuizChoiceChip> createState() => _QuizChoiceChipState();
}

class _QuizChoiceChipState extends State<QuizChoiceChip> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final prompt = widget.data['prompt'].toString();
    final options = widget.data['options'] as List<String>;

    return GenUiBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(prompt),
          const SizedBox(height: 12),
          for (var i = 0; i < options.length; i++) ...[
            if (i != 0) const SizedBox(height: 8),
            _QuizOptionRow(
              index: i,
              label: options[i],
              isSelected: selectedIndex == i,
              onTap: () => setState(() => selectedIndex = i),
            ),
          ],
        ],
      ),
    );
  }
}

class _QuizOptionRow extends StatelessWidget {
  final int index;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _QuizOptionRow({
    required this.index,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colors.primaryContainer.withAlpha(150)
                : null,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? context.colors.primary
                  : context.colors.outline.withAlpha(50),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: isSelected
                    ? context.colors.primary
                    : context.colors.outline.withAlpha(100),
                child: Text(
                  '${index + 1}',
                  style: TextType.captionLarge.copyWith(
                    color: isSelected
                        ? context.colors.onPrimary : null,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextType.captionLarge.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
