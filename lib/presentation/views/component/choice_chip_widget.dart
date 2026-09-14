import 'package:flutter/material.dart';

import 'choice_chip_item.dart';

class ChoiceChipWidget extends StatefulWidget {
  final int savedQuiz;
  final int wrongAnswer;
  int? selectedIndex;

  ChoiceChipWidget({
    super.key,
    required this.savedQuiz,
    required this.wrongAnswer,
    this.selectedIndex
  });

  @override
  State<ChoiceChipWidget> createState() => _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
  @override
  Widget build(BuildContext context) {
    final List<String> categories = ['전체', '오답', '최신순'];
    return Wrap(
      spacing: 8.0,
      children: [
        for (var i = 0; i < categories.length; i++)
          ChoiceChipItem(
            label: switch (categories[i]) {
              '전체' => Text('${categories[i]} ${widget.savedQuiz}'),
              '오답' => Text('${categories[i]} ${widget.wrongAnswer}'),
              '최신순' => Text(categories[i]),
              (_) => const Placeholder(),
            },
            isSelected: widget.selectedIndex == i,
            onSelected: (bool selected) {
              setState(() {
                widget.selectedIndex = selected ? i : widget.selectedIndex;
              });
            },
          ),
      ],
    );
  }
}
