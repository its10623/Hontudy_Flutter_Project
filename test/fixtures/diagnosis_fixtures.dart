import 'package:hontudy/domain/models/diagnosis_profile.dart';

final testDateTime = DateTime(2026, 11, 1, 12, 30);

DiagnosisProfile testProfile({
  String? background = '전공자',
  int difficultyScore = 3,
  List<String> purposeTags = const ['실무 역량 강화', '취업·이직 준비'],
  List<String> weakAreas = const ['네트워크', '데이터베이스'],
  DateTime? timestamp,
}) {
  return DiagnosisProfile(
    background: background,
    difficultyScore: difficultyScore,
    purposeTags: purposeTags,
    weakAreas: weakAreas,
    timestamp: timestamp ?? testDateTime,
  );
}

Map<String, dynamic> classificationJson({
  Object? reasoning =
      '자료구조와 네트워크 기초는 알고 있지만 데이터베이스 설계 경험은 부족해 보여요.'
      ' 실무에 바로 쓸 수 있는 문제를 원하셔서 중간 난이도로 시작해요.',
  Object? background = '전공자',
  Object? backgroundDetail = '컴퓨터공학 전공, 백엔드 인턴 3개월',
  Object? difficultyScore = 3,
  Object? purposeTags = const ['실무 역량 강화', '취업·이직 준비'],
  Object? weakAreas = const ['네트워크', '데이터베이스'],
}) {
  return {
    'reasoning': reasoning,
    'background': background,
    'background_detail': backgroundDetail,
    'difficulty_score': difficultyScore,
    'purpose_tags': purposeTags,
    'weak_areas': weakAreas,
  };
}

Map<String, dynamic> diagnosisTurnJson({
  Object? nextAction = 'continue_diagnosis',
  Object? questionText = '개발 공부는 얼마나 해보셨나요?',
  Object? widgetType = 'single_choice_list',
  Object? widgetContent = const {
    'options': ['처음이에요', '1년 미만', '1년 이상'],
  },
  Object? reasoning = '사용자의 개발 경험을 확인하기 위한 절차',
}) {
  return {
    'next_action': nextAction,
    'question_text': questionText,
    'widget_type': widgetType,
    'widget_content': widgetContent,
    'reasoning': reasoning,
  };
}
