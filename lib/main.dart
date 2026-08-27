import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/theme.dart';
import 'package:hontudy/presentation/views/pages/diagnosis_chat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const DiagnosisChatPage(),
    );
  }
}
