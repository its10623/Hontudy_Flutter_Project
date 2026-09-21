class DiagnosisScheme {
  DiagnosisScheme._();
  static const List<String> backgrounds = ['비전공자', '전공자'];
  static const List<DifficultyScore> difficultyScores = [
    DifficultyScore(
      score: 1,
      description: '완전 입문, 문법도 익숙하지 않음',
      difficultyMapping: '쉬운',
    ),
    DifficultyScore(
      score: 2,
      description: '기초는 알지만 응용이 약함',
      difficultyMapping: '중하',
    ),
    DifficultyScore(
      score: 3,
      description: '기본기는 있고 실무 적용 연습 필요',
      difficultyMapping: '중',
    ),
    DifficultyScore(
      score: 4,
      description: '실무 경험 있고 심화 학습 필요',
      difficultyMapping: '중상',
    ),
    DifficultyScore(
      score: 5,
      description: '심화 지식/최신 개념까지 다루고 싶음',
      difficultyMapping: '상',
    ),
  ];

  static const List<PurposeTag> purposeTags = [
    PurposeTag(
      tag: '입문 학습',
      meaning: '처음 배우는 중',
      effect: '개념 위주, 기초 용어 설명 포함',
    ),
    PurposeTag(
      tag: '실무 역량 강화',
      meaning: '실무 적용력 강화 목적',
      effect: 'CS 기초·실무 연계 응용 문제',
    ),
    PurposeTag(
      tag: '취업·이직 준비',
      meaning: '취업/이직 목표',
      effect: '전공 지식 전반 정리형 문제',
    ),
    PurposeTag(
      tag: '면접 직전 대비',
      meaning: '면접이 임박함',
      effect: '빈출 면접 질문 위주',
    ),
    PurposeTag(
      tag: '취미·유지보수',
      meaning: '이미 능숙, 감 유지 목적',
      effect: '다양한 주제 랜덤 출제',
    ),
  ];
}

class DifficultyScore {
  final int score;
  final String description;
  final String difficultyMapping;

  const DifficultyScore({
    required this.score,
    required this.description,
    required this.difficultyMapping,
  });
}

class PurposeTag {
  final String tag;
  final String meaning;
  final String effect;

  const PurposeTag({
    required this.tag,
    required this.meaning,
    required this.effect,
  });
}

