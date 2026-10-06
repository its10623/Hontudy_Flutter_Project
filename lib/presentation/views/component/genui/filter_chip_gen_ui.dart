import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';
import 'package:hontudy/presentation/views/component/primary_button.dart';

class FilterChipGenUi extends StatefulWidget {
  final List<String> options;
  final bool enabled;
  final ValueChanged<List<String>> onSubmit;

  const FilterChipGenUi({
    super.key,
    required this.options,
    required this.enabled,
    required this.onSubmit,
  });

  @override
  State<FilterChipGenUi> createState() => _FilterChipGenUiState();
}

class _FilterChipGenUiState extends State<FilterChipGenUi> {
  final Set<String> _selected = {};

  void _toggle(String option) {
    setState(() {
      if (!_selected.remove(option)) _selected.add(option);
    });
  }

  @override
  Widget build(BuildContext context) {
    final canSubmit = widget.enabled && _selected.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        for (final option in widget.options)
          _CheckRow(
            label: option,
            selected: _selected.contains(option),
            onTap: widget.enabled ? () => _toggle(option) : null,
          ),
        if (widget.enabled)
          PrimaryButton(
            onPressed: canSubmit
                ? () => widget.onSubmit(
                    widget.options.where(_selected.contains).toList(),
                  )
                : null,
            text: _selected.isEmpty
                ? '여러 개 고를 수 있어요'
                : '${_selected.length}개 선택 완료',
            color: ButtonColor.primary,
          ),
      ],
    );
  }
}

class _CheckRow extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _CheckRow({
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
                  selected
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked_rounded,
                  size: 20,
                  color: selected ? primary : context.colors.outline,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(label, style: context.textStyles.bodySmall),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
