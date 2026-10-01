import 'package:flutter/material.dart';

import '../component/chat/chat_appbar.dart';
import '../component/chat/chat_body.dart';

class DiagnosisChatPage extends StatefulWidget {
  const DiagnosisChatPage({super.key});

  @override
  DiagnosisChatPageState createState() => DiagnosisChatPageState();
}

class DiagnosisChatPageState extends State<DiagnosisChatPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ChatAppbar(
        pageInfo: 'AI진단',
        currentState: 'AI가 당신을 파악하고 있어요...',
        stepValue: 40,
      ),
      body: ChatBody(
        isMetadata: false,
      ),
    );
  }
}
