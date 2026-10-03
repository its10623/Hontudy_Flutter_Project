import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/views/component/check_box_widget.dart';
import 'package:hontudy/presentation/views/component/primary_button.dart';

import '../../../core/theme/context_theme_extension.dart';
import '../divider_widget.dart';
import 'gen_ui_box.dart';

class SummaryConfirm extends StatefulWidget {
  final dynamic data;
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const SummaryConfirm({
    super.key,
    this.data,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  State<SummaryConfirm> createState() => _SummaryConfirmState();
}

class _SummaryConfirmState extends State<SummaryConfirm> {
  @override
  Widget build(BuildContext context) {
    final String? prompt = widget.data['prompt']?.toString();
    final options = widget.data['options'] as List<String>;
    return GenUiBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (prompt != null) ...[
            Text(prompt),
          ] else ...[
            ?null,
          ],
          const SizedBox(
            height: 12,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: context.colors.outlineVariant,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                _SummaryRow(category: '배경', summaryResult: options[0]),
                const DividerWidget(),
                _SummaryRow(category: '난이도', summaryResult: options[1]),
                const DividerWidget(),
                _SummaryRow(category: '목적', summaryResult: options[2]),
                const DividerWidget(),
                _SummaryRow(category: '약한 영역', summaryResult: options[3]),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PrimaryButton(
                  onPressed: () {},
                  text: '수정하기',
                  color: ButtonColor.surface,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: PrimaryButton(
                  onPressed: () {},
                  text: '네, 맞아요',
                  color: ButtonColor.primary,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: widget.isChecked
                  ? context.colors.primaryContainer.withAlpha(150)
                  : context.colors.outlineVariant.withAlpha(100),
              border: BoxBorder.all(
                width: 1,
                color: widget.isChecked
                    ? context.colors.primary
                    : context.colors.outlineVariant,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: CheckBoxWidget(
              isChecked: widget.isChecked,
              onCheckedChanged: widget.onChanged,
              text: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '이 정보 기억하기',
                      style: context.captionLarge.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '다음엔 진단 없이 바로 문제부터 시작합니다',
                      style: TextType.captionLarge.copyWith(
                        color: context.colors.outline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String category;
  final String summaryResult;

  const _SummaryRow({
    required this.summaryResult,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category,
            style: TextType.captionLarge.copyWith(
              color: context.colors.outline,
            ),
          ),
          Text(
            summaryResult,
            style: TextType.captionLarge.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
