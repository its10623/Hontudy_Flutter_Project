import 'package:flutter/material.dart';
import 'package:hontudy/presentation/views/component/filter_chip_widget.dart';
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

  void _toggle(String option, bool selected) {
    setState(() {
      if (selected) {
        _selected.add(option);
      } else {
        _selected.remove(option);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final canSubmit = widget.enabled && _selected.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final option in widget.options)
              FilterChipWidget(
                label: Text(option),
                isSelected: _selected.contains(option),
                onSelected: widget.enabled
                    ? (value) => _toggle(option, value)
                    : (_) {},
              ),
          ],
        ),
        if (widget.enabled) ...[
          const SizedBox(height: 12),
          PrimaryButton(
            onPressed: canSubmit
                ? () => widget.onSubmit(
                    widget.options.where(_selected.contains).toList(),
                  )
                : null,
            text: '선택 완료',
            color: ButtonColor.primary,
          ),
        ],
      ],
    );
  }
}
