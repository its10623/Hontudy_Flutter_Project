import 'package:flutter/material.dart';
import 'package:hontudy/domain/models/diagnosis_profile.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/views/component/check_box_widget.dart';
import 'package:hontudy/presentation/views/component/primary_button.dart';

import '../../../core/theme/context_theme_extension.dart';
import '../divider_widget.dart';

class SummaryConfirm extends StatefulWidget {
  final DiagnosisResult result;
  final bool enabled;
  final Future<void> Function(bool remember) onConfirm;

  const SummaryConfirm({
    super.key,
    required this.result,
    required this.enabled,
    required this.onConfirm,
  });

  @override
  State<SummaryConfirm> createState() => _SummaryConfirmState();
}

class _SummaryConfirmState extends State<SummaryConfirm> {
  bool _remember = false;
  bool _saving = false;

  Future<void> _confirm() async {
    setState(() => _saving = true);
    try {
      await widget.onConfirm(_remember);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.result.profile;
    final canConfirm = widget.enabled && !_saving;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colors.surfaceContainerLowest,
            borderRadius: AppShape.widgetCard,
            border: Border.all(color: context.colors.primary.withAlpha(30)),
          ),
          child: Column(
            children: [
              _SummaryRow(category: '배경', value: profile.background),
              const DividerWidget(),
              _SummaryRow(
                category: '난이도',
                value: '${profile.difficultyScore}/5',
              ),
              const DividerWidget(),
              _SummaryRow(
                category: '목적',
                value: profile.purposeTags.join(', '),
              ),
              const DividerWidget(),
              _SummaryRow(
                category: '약한 영역',
                value: profile.weakAreas.isEmpty
                    ? '-'
                    : profile.weakAreas.join(', '),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.result.reasoning,
          style: context.captionMedium,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: _remember
                ? context.colors.primaryContainer.withAlpha(150)
                : context.colors.outlineVariant.withAlpha(100),
            border: Border.all(
              color: _remember
                  ? context.colors.primary
                  : context.colors.outlineVariant,
            ),
            borderRadius: AppShape.widgetCard,
          ),
          child: CheckBoxWidget(
            isChecked: _remember,
            onCheckedChanged: canConfirm
                ? (value) => setState(() => _remember = value)
                : (_) {},
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
        const SizedBox(height: 12),
        PrimaryButton(
          onPressed: canConfirm ? _confirm : null,
          text: _saving ? '저장 중...' : '네, 맞아요',
          color: ButtonColor.primary,
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String category;
  final String value;

  const _SummaryRow({required this.category, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            category,
            style: TextType.captionLarge.copyWith(
              color: context.colors.outline,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextType.captionLarge.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
