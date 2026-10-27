import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hontudy/domain/models/quiz.dart';
import 'package:hontudy/domain/models/report.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/viewmodels/report_viewmodel.dart';
import 'package:hontudy/presentation/views/component/error_dialog.dart';
import 'package:hontudy/presentation/views/component/primary_button.dart';

const _maxDescriptionLength = 500;

class ReportDialog extends ConsumerStatefulWidget {
  final String userPrompt;
  final String aiResponse;
  final ReportScreen reportScreen;
  final Quiz? quiz;

  const ReportDialog({
    super.key,
    required this.userPrompt,
    required this.aiResponse,
    required this.reportScreen,
    this.quiz,
  });

  @override
  ConsumerState<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends ConsumerState<ReportDialog> {
  final TextEditingController _detailsController = TextEditingController();
  ReportReason? _selectedReason;

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  void _submit() {
    final description = _detailsController.text.trim();
    final report = Report(
      userPrompt: widget.userPrompt,
      aiResponse: widget.aiResponse,
      reportReason: _selectedReason!,
      timestamp: DateTime.now(),
      reportScreen: widget.reportScreen,
      quiz: widget.quiz,
      description: description.isEmpty ? null : description,
    );
    ref.read(reportViewModelProvider.notifier).submitReport(report);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(reportViewModelProvider).isLoading;

    ref.listen(reportViewModelProvider, (prev, next) {
      if (prev?.isLoading != true) return;
      if (next is AsyncData) {
        final messenger = ScaffoldMessenger.of(context);
        Navigator.of(context).pop();
        messenger.showSnackBar(
          const SnackBar(content: Text('신고가 접수되었습니다. 검토 후 조치하겠습니다.')),
        );
      } else if (next is AsyncError) {
        ErrorDialog.show(context: context, error: next.error);
      }
    });

    return AlertDialog(
      backgroundColor: context.colors.surface,
      shape: const RoundedRectangleBorder(borderRadius: AppShape.widgetCard),
      title: Text(
        'AI 응답 신고',
        style: TextType.headlineSmall.copyWith(fontWeight: FontWeight.w700),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '신고 사유를 선택해 주세요.\n신고한 AI 응답과 직전 입력은 검토를 위해 저장됩니다.',
              style: context.captionLarge,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ReportReason>(
              isExpanded: true,
              borderRadius: AppShape.option,
              dropdownColor: context.colors.surface,
              style: context.textStyles.bodyLarge,
              decoration: _fieldDecoration(
                context,
                label: '신고 사유',
                radius: AppShape.option,
              ),
              items: [
                for (final reason in ReportReason.values)
                  DropdownMenuItem(value: reason, child: Text(reason.label)),
              ],
              onChanged: isLoading
                  ? null
                  : (value) => setState(() => _selectedReason = value),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _detailsController,
              enabled: !isLoading,
              maxLines: 4,
              maxLength: _maxDescriptionLength,
              style: context.textStyles.bodyLarge,
              decoration: _fieldDecoration(
                context,
                label: '상세 내용 (선택)',
                hint: '문제가 되는 부분을 적어 주시면 검토에 도움이 됩니다.',
                radius: AppShape.widgetCard,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: PrimaryButton(
                onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                text: '취소',
                color: ButtonColor.surface,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: PrimaryButton(
                onPressed: _selectedReason == null || isLoading
                    ? null
                    : _submit,
                text: isLoading ? '보내는 중' : '신고하기',
                color: ButtonColor.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

InputDecoration _fieldDecoration(
  BuildContext context, {
  required String label,
  required BorderRadius radius,
  String? hint,
}) {
  OutlineInputBorder outline(Color color, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: color, width: width),
      );

  return InputDecoration(
    labelText: label,
    labelStyle: context.captionLarge,
    floatingLabelStyle: context.captionLarge.copyWith(
      color: context.colors.primary,
    ),
    hintText: hint,
    hintStyle: context.captionLarge,
    alignLabelWithHint: true,
    counterStyle: context.captionSmall,
    border: outline(context.colors.outline.withAlpha(50)),
    enabledBorder: outline(context.colors.outline.withAlpha(50)),
    disabledBorder: outline(context.colors.outline.withAlpha(25)),
    focusedBorder: outline(context.colors.primary, width: 2),
  );
}

extension ReportReasonLabel on ReportReason {
  String get label => switch (this) {
    ReportReason.inappropriate => '부적절하거나 유해한 내용',
    ReportReason.hallucination => '사실과 다른 정보',
    ReportReason.privacyLeak => '개인정보 노출',
    ReportReason.incorrectData => '문제·정답 오류',
    ReportReason.other => '기타',
  };
}
