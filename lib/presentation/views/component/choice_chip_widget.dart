import 'package:flutter/material.dart';

import 'choice_chip_item.dart';

class ChoiceChipWidget extends StatelessWidget {
  final int solvedCount;
  final int wrongCount;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const ChoiceChipWidget({
    super.key,

    required this.selectedIndex,
    required this.onSelected,
    required this.solvedCount,
    required this.wrongCount,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> labels = [
      '전체 $solvedCount',
      '오답 $wrongCount',
      '정답 ${solvedCount - wrongCount}',
    ];
    return Wrap(
      spacing: 8.0,
      children: [
        for (var i = 0; i < labels.length; i++)
          ChoiceChipItem(
            label: Text(labels[i]),
            isSelected: selectedIndex == i,
            onSelected: (_) => onSelected(i),
          ),
      ],
    );
  }
}
