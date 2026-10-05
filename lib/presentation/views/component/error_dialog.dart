import 'package:flutter/material.dart';

import '../../../domain/exceptions.dart';
import 'dialog_widget.dart';

class ErrorDialog {
  ErrorDialog._();

  static Future<void> show({
    required BuildContext context,
    required Object error,
    String buttonText = '확인',
    bool barrierDismissible = true,
    VoidCallback? onPressed,
  }) {
    final (title, message) = switch (error) {
      NetworkException() => ('네트워크 오류', '인터넷 연결을 확인하고 다시 시도해 주세요'),
      ServerException() => ('서버 오류', '서버 점검 중이거나 일시적인 오류가 발생했습니다'),
      AiUsageLimitExceededException() => (
        '오늘 사용량을 모두 썼어요',
        '내일 다시 시도해 주세요',
      ),
      _ => ('오류', '알 수 없는 오류가 발생했습니다'),
    };

    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) => DialogWidget(
        title: title,
        content: message,
        primaryText: buttonText,
        primaryOnPressed: () {
          Navigator.of(dialogContext).pop();
          onPressed?.call();
        },
      ),
    );
  }
}
