import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';

class DiagnosisChoiceList extends StatefulWidget {
  final List<String> options;
  final bool enabled;
  final ValueChanged<String> onSelected;
  final String? answer;

  const DiagnosisChoiceList({
    super.key,
    required this.options,
    required this.enabled,
    required this.onSelected,
    this.answer,
  });

  @override
  State<DiagnosisChoiceList> createState() => _DiagnosisChoiceListState();
}

class _DiagnosisChoiceListState extends State<DiagnosisChoiceList> {
  String? _selected;

  void _select(String option) {
    setState(() => _selected = option);
    widget.onSelected(option);
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.answer ?? _selected;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        for (final option in widget.options)
          _OptionRow(
            label: option,
            selected: selected == option,
            onTap: widget.enabled ? () => _select(option) : null,
          ),
      ],
    );
  }
}

class _OptionRow extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _OptionRow({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.colors.primary;
    final enabled = onTap != null;
    return Opacity(
      opacity: enabled || selected ? 1 : 0.5,
      child: Material(
        color: selected
            ? primary.withAlpha(20)
            : context.colors.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: AppShape.option,
          side: BorderSide(color: selected ? primary : Colors.transparent),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 18,
                  color: primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(label, style: context.textStyles.bodySmall),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: context.colors.outline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
