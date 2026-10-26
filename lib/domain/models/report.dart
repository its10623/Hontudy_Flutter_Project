import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hontudy/domain/models/quiz.dart';

part 'report.freezed.dart';

@freezed
class Report with _$Report {
  final String userPrompt;
  final String aiResponse;
  final ReportReason reportReason;
  final ReportScreen reportScreen;
  final Quiz? quiz;
  final String? description;
  final DateTime timestamp;

  Report({
    required this.userPrompt,
    required this.aiResponse,
    required this.reportReason,
    required this.timestamp,
    this.description,
    this.quiz,
    required this.reportScreen,
  });
}

enum ReportScreen { diagnosis, quiz }

enum ReportReason {
  inappropriate, // 욕설, 차별, 유해 콘텐츠
  hallucination, // 허위 사실 유포, 환각 현상
  privacyLeak, // 개인정보 노출
  incorrectData, // 학습/문제 오류 및 정답 불일치 (혼터디 전용)
  other, // 기타 불쾌한 콘텐츠
}
