import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/app_colors.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';

import 'gen_ui_box.dart';

enum AnswerResult { correct, wrong }

class AnswerFeedback extends StatelessWidget {
  final AnswerResult answerResult;
  final String wrongAnswerNote;
  final String explanation;
  final String? keyPoint;

  const AnswerFeedback({
    super.key,
    required this.answerResult,
    required this.wrongAnswerNote,
    required this.explanation,
    this.keyPoint,
  });

  bool get _isCorrect => answerResult == AnswerResult.correct;

  @override
  Widget build(BuildContext context) {
    return GenUiBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: _isCorrect
                      ? AppColors.correctSurface
                      : AppColors.wrongSurface,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  _isCorrect ? '정답' : '오답',
                  style: TextType.captionSmall.copyWith(
                    fontWeight: FontWeight.w800,
                    color: _isCorrect ? AppColors.correct : AppColors.wrong,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                wrongAnswerNote,
                style: TextType.captionSmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colors.outline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          Text(
            explanation,
            style: TextType.captionLarge.copyWith(
              fontWeight: FontWeight.w500,
              height: 1.6,
              color: context.colors.onSurface,
            ),
          ),
          if (keyPoint != null) ...[
            const SizedBox(height: 11),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.colors.primaryContainer.withAlpha(60),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.colors.primaryContainer),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '핵심만 다시',
                    style: TextType.captionSmall.copyWith(
                      fontWeight: FontWeight.w800,
                      color: context.colors.primary,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    keyPoint!,
                    style: TextType.captionMedium.copyWith(
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: context.colors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
