import 'package:flutter/material.dart';

import '../../core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';

Future<bool> showTermsAgreementSheet(
  BuildContext context, {
  void Function(int index)? onOpenTerm,
}) async {
  final agreed = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withAlpha(102),
    builder: (_) => TermsAgreementSheet(onOpenTerm: onOpenTerm),
  );
  return agreed ?? false;
}

class _Term {
  const _Term(this.label);
  final String label;
}

const _terms = [
  _Term('서비스 이용약관'),
  _Term('개인정보 수집 및 이용'),
];

class TermsAgreementSheet extends StatefulWidget {
  const TermsAgreementSheet({super.key, this.onOpenTerm});

  final void Function(int index)? onOpenTerm;

  @override
  State<TermsAgreementSheet> createState() => _TermsAgreementSheetState();
}

class _TermsAgreementSheetState extends State<TermsAgreementSheet> {
  final List<bool> _checked = List.filled(_terms.length, false);

  bool get _allChecked => _checked.every((v) => v);

  void _toggleAll() {
    final next = !_allChecked;
    setState(() => _checked.fillRange(0, _checked.length, next));
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: AppShape.sheetTop,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(20, 14, 20, 36 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.colors.outlineVariant,
                borderRadius: AppShape.pill,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '서비스 이용을 위해\n약관에 동의해주세요',
            style: context.textStyles.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              height: 1.35,
              color: context.colors.onSurface,
            ),
          ),
          const SizedBox(height: 20),
          Material(
            color: context.colors.surface,
            borderRadius: AppShape.option,
            child: InkWell(
              borderRadius: AppShape.option,
              onTap: _toggleAll,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 15,
                ),
                child: Row(
                  children: [
                    _CheckCircle(checked: _allChecked),
                    const SizedBox(width: 11),
                    Text(
                      '전체 동의',
                      style: context.textStyles.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: context.colors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                for (var i = 0; i < _terms.length; i++)
                  _TermRow(
                    term: _terms[i],
                    checked: _checked[i],
                    onToggle: () => setState(() => _checked[i] = !_checked[i]),
                    onOpen: widget.onOpenTerm == null
                        ? null
                        : () => widget.onOpenTerm!(i),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 54,
            child: FilledButton(
              onPressed: _allChecked
                  ? () => Navigator.of(context).pop(true)
                  : null,
              style: FilledButton.styleFrom(
                backgroundColor: context.colors.primary,
                disabledBackgroundColor: context.colors.primaryContainer,
                foregroundColor: context.colors.onPrimary,
                disabledForegroundColor: context.colors.onPrimary,
                shape: const RoundedRectangleBorder(
                  borderRadius: AppShape.option,
                ),
                textStyle: context.textStyles.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text('동의하고 시작하기'),
            ),
          ),
        ],
      ),
    );
  }
}

class _TermRow extends StatelessWidget {
  const _TermRow({
    required this.term,
    required this.checked,
    required this.onToggle,
    required this.onOpen,
  });

  final _Term term;
  final bool checked;
  final VoidCallback onToggle;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onToggle,
            borderRadius: AppShape.segment,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 2),
              child: Row(
                children: [
                  _CheckCircle(checked: checked),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '[필수] ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: context.colors.primary,
                            ),
                          ),
                          TextSpan(text: term.label),
                        ],
                      ),
                      style: context.textStyles.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colors.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (onOpen != null)
          IconButton(
            onPressed: onOpen,
            icon: Icon(
              Icons.chevron_right,
              size: 20,
              color: context.colors.onSurfaceVariant.withAlpha(120),
            ),
            visualDensity: VisualDensity.compact,
            tooltip: '약관 보기',
          ),
      ],
    );
  }
}

class _CheckCircle extends StatelessWidget {
  const _CheckCircle({required this.checked});
  final bool checked;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: checked ? context.colors.primary : Colors.transparent,
        border: checked
            ? null
            : Border.all(
                color: context.colors.outline.withAlpha(100),
                width: 1.5,
              ),
      ),
      child: checked
          ? Icon(Icons.check_rounded, size: 14, color: context.colors.onPrimary)
          : null,
    );
  }
}
