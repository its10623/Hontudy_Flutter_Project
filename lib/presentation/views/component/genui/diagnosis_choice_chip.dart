import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/views/component/choice_chip_item.dart';

import 'gen_ui_box.dart';

class DiagnosisChoiceChip extends StatefulWidget {
  final dynamic data;

  const DiagnosisChoiceChip({super.key, this.data});

  @override
  State<DiagnosisChoiceChip> createState() => _DiagnosisChoiceChipState();
}

class _DiagnosisChoiceChipState extends State<DiagnosisChoiceChip> {
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
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (var i = 0; i < options.length; i++)
                ChoiceChipItem(
                  label: Text(options[i]),
                  isSelected: selectedIndex == i,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedIndex = selected ? i : selectedIndex;
                    });
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
