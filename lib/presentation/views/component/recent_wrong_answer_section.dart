import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/app_colors.dart';

import '../../core/theme/context_theme_extension.dart';
import '../../core/theme/text_type.dart';

class RecentWrongAnswerSection extends StatefulWidget {
  final String wrongQuiz;
  final int timeAgo;
  final VoidCallback onTap;

  const RecentWrongAnswerSection({
    super.key,
    required this.wrongQuiz,
    required this.onTap,
    required this.timeAgo,
  });

  @override
  State<RecentWrongAnswerSection> createState() =>
      _RecentWrongAnswerSectionState();
}

class _RecentWrongAnswerSectionState extends State<RecentWrongAnswerSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.colors.outline.withAlpha(50),
            blurRadius: 30,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: context.colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashColor: context.colors.primary.withAlpha(30),
          highlightColor: context.colors.primary.withAlpha(50),
          borderRadius: BorderRadius.circular(10),
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 8,
                  color: AppColors.wrong,
                ),
                SizedBox(width: 6,),
                Text(
                  widget.wrongQuiz,
                  style: TextType.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  '${widget.timeAgo}일 전',
                  style: context.captionMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
