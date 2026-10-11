import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/app_colors.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/views/component/primary_button.dart';

class QuizChoiceChip extends StatefulWidget {
  final List<String> options;
  final bool enabled;
  final String? submittedAnswer;
  final int? correctIndex;
  final ValueChanged<String> onSubmit;

  const QuizChoiceChip({
    super.key,
    required this.options,
    required this.enabled,
    required this.onSubmit,
    this.submittedAnswer,
    this.correctIndex,
  });

  @override
  State<QuizChoiceChip> createState() => _QuizChoiceChipState();
}

class _QuizChoiceChipState extends State<QuizChoiceChip> {
  int? _selectedIndex;

  int? get _shownIndex {
    final submitted = widget.submittedAnswer;
    if (submitted == null) return _selectedIndex;
    final index = widget.options.indexOf(submitted);
    return index < 0 ? null : index;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _shownIndex;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        for (var i = 0; i < widget.options.length; i++)
          _QuizOptionRow(
            index: i,
            label: widget.options[i],
            isSelected: selectedIndex == i,
            result: switch (widget.correctIndex) {
              null => null,
              final correct when i == correct => _OptionResult.correct,
              _ when selectedIndex == i => _OptionResult.wrong,
              _ => null,
            },
            onTap: widget.enabled
                ? () => setState(() => _selectedIndex = i)
                : null,
          ),
        if (widget.enabled)
          PrimaryButton(
            onPressed: _selectedIndex == null
                ? null
                : () => widget.onSubmit(widget.options[_selectedIndex!]),
            text: '제출하기',
            color: ButtonColor.primary,
          ),
      ],
    );
  }
}

enum _OptionResult { correct, wrong }

class _QuizOptionRow extends StatelessWidget {
  final int index;
  final String label;
  final bool isSelected;
  final _OptionResult? result;
  final VoidCallback? onTap;

  const _QuizOptionRow({
    required this.index,
    required this.label,
    required this.isSelected,
    required this.result,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.colors.primary;
    final (accent, background) = switch (result) {
      _OptionResult.correct => (AppColors.correct, AppColors.correctSurface),
      _OptionResult.wrong => (AppColors.wrong, AppColors.wrongSurface),
      null when isSelected => (primary, primary.withAlpha(20)),
      null => (null, context.colors.surfaceContainerLow),
    };
    return Material(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: AppShape.option,
        side: BorderSide(color: accent ?? Colors.transparent),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor:
                    accent ?? context.colors.outline.withAlpha(100),
                child: Text(
                  '${index + 1}',
                  style: TextType.captionLarge.copyWith(
                    color: context.colors.onPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(label, style: context.textStyles.bodySmall),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
