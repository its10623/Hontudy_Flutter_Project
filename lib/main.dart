import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hontudy/presentation/core/theme/theme.dart';
import 'package:hontudy/presentation/views/component/dialog_widget.dart';
import 'package:hontudy/presentation/views/component/genui/code_block.dart';
import 'package:hontudy/presentation/views/component/shimmer_wrapper.dart';
import 'package:hontudy/presentation/views/component/skeleton_box.dart';
import 'package:hontudy/presentation/views/pages/diagnosis_chat_page.dart';
import 'package:hontudy/presentation/views/pages/note_detail_page.dart';
import 'package:hontudy/presentation/views/pages/note_summary_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: DiagnosisChatPage()
    );
  }
}


class DialogText extends StatelessWidget {
  const DialogText ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogWidget(
                  title: '네트워크 연결이 원할하지 않습니다',
                  content: '잠시 후 다시 시도해 주세요',
                  primaryText: '확인',
                  primaryOnPressed: () {},
                  secondaryText: '취소',
                  secondaryOnPressed: () {},
                );
              },
            );
          },
          child: Text('Show Dialog'),
        ),
      ),
    );
  }
}
