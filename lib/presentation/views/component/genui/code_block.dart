import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hontudy/presentation/views/component/divider_widget.dart';

class CodeBlock extends StatelessWidget {
  final dynamic data;

  const CodeBlock({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final language = data['language'].toString();
    final code = data['code'].toString();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
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
                  language,
                  style: GoogleFonts.firaCode(
                      fontSize: 14,
                      color: context.colors.outline
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
          DividerWidget(),
          SizedBox(
            width: double.infinity,
            child: HighlightView(
              code,
              language: language,
              theme: isDarkMode ? atomOneDarkTheme : githubTheme,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
              textStyle: GoogleFonts.firaCode(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
