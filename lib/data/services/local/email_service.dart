import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailService {
  Future<void> sendInquiry({
    required String recipient,
    required String subject,
    required String body,
  }) async {
    final email = Email(
      subject: subject,
      recipients: [recipient],
      body: body,
      attachments: const [],
    );

    await FlutterEmailSender.send(email);
  }
}
