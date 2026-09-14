import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/views/component/filter_chip_widget.dart';

class FilterChipGenUi extends StatefulWidget {
  final dynamic data;

  const FilterChipGenUi({
    super.key,
    this.data,
  });

  @override
  State<FilterChipGenUi> createState() => _FilterChipGenUiState();
}

class _FilterChipGenUiState extends State<FilterChipGenUi> {
  Set<String> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    final prompt = widget.data['prompt'].toString();
    final options = widget.data['options'] as List<String>;

    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colors.surfaceContainerLowest,
            borderRadius: BorderRadius.all(Radius.circular(16)),
            border: Border.all(
              width: 1,
              color: context.colors.outline.withAlpha(50),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(prompt),
              const SizedBox(height: 8,),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  for (var i = 0; i < options.length; i++) ...[
                    FilterChipWidget(
                      label: Text(options[i]),
                      onSelected: (value) {
                        setState(() {
                          if (value) {
                            selectedOptions.add(options[i]);
                          } else {
                            selectedOptions.remove(options[i]);
                          }
                        });
                      },
                      isSelected: selectedOptions.contains(options[i]),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
