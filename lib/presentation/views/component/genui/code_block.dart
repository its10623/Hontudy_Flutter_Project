import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hontudy/presentation/views/component/divider_widget.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';

class CodeBlock extends StatelessWidget {
  final String language;
  final String code;

  const CodeBlock({
    super.key,
    required this.language,
    required this.code,
  });

  static const _plainLanguages = {'', 'text', 'plaintext', 'plain'};

  @override
  Widget build(BuildContext context) {
    final label = _plainLanguages.contains(language.toLowerCase())
        ? '예시'
        : language;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: AppShape.button,
        border: Border.all(
          color: context.colors.outlineVariant,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  label,
                  style: GoogleFonts.firaCode(
                    fontSize: 14,
                    color: context.colors.outline,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy_rounded, size: 20),
                color: context.colors.outline,
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: code));
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('코드가 클립보드에 복사되었습니다.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          const DividerWidget(),
          LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: HighlightView(
                  code,
                  language: language,
                  theme: isDarkMode ? atomOneDarkTheme : githubTheme,
                  padding: const EdgeInsets.all(16),
                  textStyle: GoogleFonts.firaCode(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
