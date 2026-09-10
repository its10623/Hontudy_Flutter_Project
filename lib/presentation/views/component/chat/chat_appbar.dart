import 'package:flutter/material.dart';
import 'package:hontudy/presentation/views/component/divider_widget.dart';

import '../../../core/theme/context_theme_extension.dart';
import '../progress_bar_widget.dart';

class ChatAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String pageInfo;
  final String currentState;
  final int? stepValue;
  final Widget? onNote;
  final Widget? onProfile;

  const ChatAppbar({
    super.key,
    required this.pageInfo,
    required this.currentState,
    this.stepValue,
    this.onNote,
    this.onProfile,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/icons/ai_icon.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pageInfo,
                    style: context.textStyles.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text.rich(
                      TextSpan(
                        children: [
                          if(stepValue != null)
                            TextSpan(
                            text: '진단률 $stepValue% · ',
                            style: context.captionSmall.copyWith(
                              color: context.captionSmall.color?.withValues(alpha: 0.6),
                            )
                          ),
                          TextSpan(
                              text: currentState,
                              style: context.captionSmall.copyWith(
                                color: context.captionSmall.color?.withValues(alpha: 0.6),
                              )
                          )
                        ]
                      )
                  )
                ],
              ),

              if(onNote != null && onProfile != null)... [
                Spacer(),
                onNote!,
                SizedBox(
                  width: 10,
                ),
                onProfile!
              ],
              Spacer()
            ],
          ),
          SizedBox(height: 4,),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: stepValue != null
                ? _AnimatedStepIndicator(stepValue: stepValue!)
                : null,
          ),
          SizedBox(height: 4,),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: .fromHeight(1.0),
        child: DividerWidget()
      ),
    );
  }
}

class _AnimatedStepIndicator extends StatelessWidget {
  final int stepValue;

  const _AnimatedStepIndicator({
    super.key,
    required this.stepValue,
  });

  @override
  Widget build(BuildContext context) {
    final double parseValue = stepValue / 100.0;
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: stepValue / 100.0),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, child) {
        return ProgressBarWidget(value: parseValue);
      },
    );
  }
}
