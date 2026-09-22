import 'dart:convert';

import '../domain/models/category_scheme.dart';
import '../domain/models/diagnosis_profile.dart';
import '../domain/models/diagnosis_scheme.dart';
import '../domain/models/diagnosis_turn.dart';
import '../domain/models/quiz.dart';

class PromptBuilder {
  static String _role(String text) => '[역할 부여]\n$text';

  static String _taskDescription(String text) => '[과업 설명]\n$text';

  static String _constraints(List<String> rules) =>
      '[제약 조건]\n ${rules.map((r) => '- $r').join('\n')}';

  static String _referenceData(String data) => '[참고 데이터]\n$data';

  static String _encapsulateUserInput(String tag, String content) =>
      '[사용자 입력 캡슐화]\n<$tag>\n$content\n</$tag>';

  static String _orderDeduction(String content) => '[추론 순서 지정]\n$content';

  static String _forceFormattedOutput(
    String content,
    Map<String, dynamic> form,
  ) => '[출력 형식 강제]\n$content${jsonEncode(form)}';

  static String _validateSelfPrompt(String content) => '[자체 검증 지시]\n$content';

  static String _serializeHistory(List<DiagnosisAnswer> history) {
    if (history.isEmpty) return '(대화 이력 없음)';

    return history
        .map((turn) => 'Q: ${turn.questionText}\nA: ${turn.answerText}')
        .join('\n\n');
  }

  static String _serializeDiagnosisCatalog() {
    return jsonEncode({
      'backgrounds': DiagnosisScheme.backgrounds,
      'difficulty_scores': DiagnosisScheme.difficultyScores
          .map(
            (d) => {
              'score': d.score,
              'description': d.description,
              'difficulty_mapping': d.difficultyMapping,
            },
          )
          .toList(),
      'purpose_tags': DiagnosisScheme.purposeTags
          .map(
            (p) => {
              'tag': p.tag,
              'meaning': p.meaning,
              'effect': p.effect,
            },
          )
          .toList(),
    });
  }

  static String _serializeCategoryCatalog() {
    return jsonEncode({
      'main_categories': CategoryScheme.mainCategories
          .map(
            (c) => {
              'name': c.name,
              'short_label': c.shortLabel,
              'topics': c.topics,
            },
          )
          .toList(),
    });
  }

  static String _difficultyMapping(int score) {
    final match = DiagnosisScheme.difficultyScores.firstWhere(
      (d) => d.score == score,
      orElse: () => DiagnosisScheme.difficultyScores.first,
    );
    return match.difficultyMapping;
  }

  static String _purposeTagEffects(List<String> tags) {
    final effects = <String>[];
    for (final tag in tags) {
      final matches = DiagnosisScheme.purposeTags.where((p) => p.tag == tag);
      if (matches.isNotEmpty) {
        effects.add('$tag: ${matches.first.effect}');
      }
    }
    return effects.join(', ');
  }

  static String buildDiagnosisPrompt({
    required int turnCount,
    required List<DiagnosisAnswer> history,
    required DiagnosisAnswer userInput,
  }) {
    return '''
${_role('''당신은 혼터디의 진단 AI입니다. 격려하는 1타 강사 톤을 유지하되,
불필요한 서론 없이 바로 질문하세요.''')}
${_taskDescription('''사용자의 IT 학습 배경과 수준을 파악하기 위한 다음 질문을 생성하세요.
현재 $turnCount번째 턴입니다 (최소 2, 최대 8).''')}
${_constraints([
      '한 번에 하나의 질문만 하세요',
      '사용자가 아직 답하지 않은 정보만 물으세요',
      '배경/난이도/목적 태그를 섣불리 단정짓지 말고, 확신도가 낮으면 계속 질문하세요',
      '대화 이력({conversation_history})을 참고해 이미 물은 질문은 반복하지 마세요',
      '대화 이력에서 이미 사용한 문장 구조·어투를 반복하지 말고, 매 턴 다른 표현으로 질문하세요',
      '질문 성격에 맞는 위젯 타입을 다양하게 활용하고, 직전 턴들에서 이미 사용한 위젯 타입에 치우치지 마세요',
    ])}
${_referenceData('''아래는 진단 프로필 분류 기준(배경/난이도 스코어/목적 태그)입니다 (판단 기준으로만 참고, 사용자에게 노출 금지):
${_serializeDiagnosisCatalog()}''')}
${_encapsulateUserInput('conversation_history', _serializeHistory(history))}
${_encapsulateUserInput('user_response', userInput.answerText)}
${_orderDeduction('''다음 순서로 답하세요:
① 지금까지의 답변으로 배경/난이도 스코어/목적 태그가 각각 어느 쪽에 가까운지 판단 근거를 1~2줄로 정리
② 그 판단의 확신도(0~100)를 매기세요''')}
${_forceFormattedOutput('아래 JSON 형식으로만 응답하세요:', {
      'reasoning': 'string (근거 1~2줄)',
      'confidence': 'number (0~100)',
      'next_action': 'continue_diagnosis | ready_to_classify | user_requested_problem',
      'widget_type': 'free_text_input | choice_chips | single_choice_list | summary_confirm',
      'question_text': 'string',
      'widget_content': 'object | null (위젯 타입에 맞는 콘텐츠)',
    })}
''';
  }

  static String buildDiagnosisClassificationPrompt(
    List<DiagnosisAnswer> history,
  ) {
    return '''
${_role('당신은 혼터디의 진단 분류 AI입니다.')}
${_taskDescription('아래 대화 전체를 바탕으로 사용자의 배경, 난이도 스코어(1~5), 목적 태그(복수 가능)를 결정하세요.')}
${_constraints([
      '자유 서술 금지, 반드시 정해진 스키마 값만 사용',
      'background는 "비전공자"/"전공자" 중 하나만',
      'difficulty_score는 1~5 사이 정수 하나만',
      'purpose_tags는 기준표의 5개 태그 중 1개 이상 선택 (다중 선택 가능)',
      'purpose_tags에 "입문 학습"이 포함되면 difficulty_score는 1~2를 벗어나면 안 됨',
      '애매하면 가장 근접한 값 선택 후 confidence를 낮게 표시 (억지로 단정짓지 않음)',
      '확신도가 낮아도(임계치 미달) 가장 근접한 값을 반드시 출력 (difficulty_score는 추정치 ±1 범위, purpose_tags는 가장 유력한 것 1개만)',
      'reasoning은 사용자에게 그대로 노출될 수 있으므로, "difficulty_score=2로 판단" 같은 내부 변수명 언급 없이 자연스러운 문장으로 작성',
      'background_detail은 대화에서 언급된 구체적 경험을 짧게 요약. 언급된 게 없으면 null',
      'weak_areas는 category_catalog의 메인 카테고리 중에서만 1~3개 선택. 화이트리스트 밖의 값은 출력 금지. 확인되지 않으면 null',
    ])}
${_referenceData('''${_serializeDiagnosisCatalog()}
${_serializeCategoryCatalog()}''')}
${_encapsulateUserInput('conversation_history', _serializeHistory(history))}
${_orderDeduction('''다음 순서로 답하세요: 
① 판단 근거 1~2줄 정리 → 
② background/difficulty_score/purpose_tags 및 확신도 출력''')}
${_forceFormattedOutput('아래 JSON 형식으로만 응답하세요:', {
      'reasoning': 'string',
      'background': '비전공자 | 전공자',
      'background_detail': 'string | null',
      'difficulty_score': 'number (1~5)',
      'purpose_tags': ['string', '...'],
      'weak_areas': ['string', '...'],
      'confidence': 'number (0~100)',
    })}
''';
  }

  static String buildQuizPrompt({
    required DiagnosisProfile profile,
    required List<String> excludeKeywords,
  }) {
    return '''
${_role('당신은 대학교 컴퓨터공학 학부 수준의 검증된 지식만 다루는 1타 강사입니다.')}
${_taskDescription('''아래 사용자 프로필에 맞는 문제를 1개 출제하세요.
- 배경: ${profile.background} (전공자면 전문용어 그대로, 비전공자면 쉬운 비유 포함해 설명)
- 난이도: 스코어 ${profile.difficultyScore} → ${_difficultyMapping(profile.difficultyScore)} 난이도로 출제
- 목적: ${profile.purposeTags.join(', ')} → ${_purposeTagEffects(profile.purposeTags)} 를 문제 스타일에 반영''')}
${_constraints([
      '최신 트렌드/미검증 기술블로그 의견 배제',
      '인사말/서론/설명 문구 절대 포함 금지 ("네, 문제를 만들어 드릴게요" 등)',
      '정답은 무조건 1개, 애매한 논란 소지 있는 문장 금지',
      '카테고리는 메인/메인주제/서브주제 3단계로 세분화',
      '아래 제외 키워드에 해당하는 주제는 출제하지 마세요: ${excludeKeywords.join(', ')}',
      '제외 키워드를 다 피해서 이 서브주제 내에서 더 이상 출제할 개념이 없다면, 억지로 애매하거나 중복된 문제를 만들지 말고 is_exhausted: true만 반환하세요 (이 경우 다른 필드는 비워도 됨)',
      'widget_type이 single_choice_question이면 correct_index로만 정답을 표기하고 reference_answer는 null로 두세요. 그 외 위젯 타입(short_answer_input/code_block/math_formula/image_diagram)은 reference_answer에 모범 답안을 문장으로 작성하세요',
    ])}
${_forceFormattedOutput('아래 JSON 형식으로만 응답하세요:', {
      'is_exhausted': 'boolean — true면 아래 필드 생략 가능',
      'category': {'main': 'string', 'topic': 'string', 'subtopic': 'string'},
      'difficulty': '하 | 중하 | 중 | 중상 | 상',
      'widget_type': 'code_block | image_diagram | math_formula | single_choice_question | short_answer_input',
      'question_text': 'string',
      'widget_content': 'object | null',
      'choices': ['string', '...'],
      'correct_index': 'number (0~4) | null',
      'reference_answer': 'string | null',
      'self_check_passed': 'boolean',
    })}
${_validateSelfPrompt('''출력하기 전, 위 제약조건을 모두 지켰는지 스스로 점검하세요.
위반 사항이 있다면 문제를 다시 작성한 뒤 최종안만 출력하고,
검토를 통과했다면 self_check_passed를 true로 표시하세요.''')}
''';
  }

  static String buildFeedbackPrompt({
    required Quiz quiz,
    required String userAnswer,
  }) {
    return '''
${_role('1타 강사 페르소나, 격려 톤앤매너 유지.')}
${_taskDescription('''사용자가 제출한 답변을 아래 모범 답안과 비교해 의미상 맞는지 판단하고, 해설과 피드백을 제공하세요.
- 문제: ${quiz.questionText}
- 모범 답안(참고용, 글자 그대로 일치 안 해도 의미가 맞으면 정답으로 판단): ${quiz.referenceAnswer}''')}
${_constraints([
      '정답과 해설만 주지 말고 오답에 대한 구체적 피드백 포함',
      '객관식 오답 선지는 정답과 미세한 뉘앙스 차이가 아니라 핵심 개념을 명백히 거스르는 것으로 이미 구성돼 있음 — 왜 틀렸는지 핵심 개념 기준으로 설명',
      '주관식은 표현이 달라도 핵심 개념이 맞으면 정답으로 판단 (예: "NAT"와 "네트워크 주소 변환"은 동일 정답) — 글자 단위 일치를 요구하지 말 것',
      '중요한 단어/문장은 Bold 처리',
      '이해를 돕는 짧은 코드 블럭/수식 활용 가능',
      '불필요한 서론 없이 바로 피드백',
      '이해를 돕는 데 시각 자료(다이어그램)가 유용하면 image_url을 채우고, 코드 예시가 유용하면 code_block을 채우세요 — 상호배타적이지 않으므로 둘 다 필요하면 둘 다 채워도 됨. 필요 없으면 각각 null',
      '설명이 길어질 경우, 핵심만 한 줄로 요약한 key_point를 추가로 제공하세요 (짧은 설명이면 null로 생략 가능)',
    ])}
${_encapsulateUserInput('user_response', userAnswer)}
${_forceFormattedOutput('아래 JSON 형식으로만 응답하세요:', {
      'widget_type': 'answer_feedback',
      'is_correct': 'boolean — 위젯 타입 무관하게 이 프롬프트가 항상 직접 판단',
      'feedback_text': 'string (마크다운 Bold 포함)',
      'key_point': 'string | null — 핵심 요약 1줄, 짧은 설명이면 생략',
      'code_block': '{ "language": string, "code": string } | null',
      'image_url': 'string | null',
    })}
''';
  }

  static String buildSttPrompt(List<String> csTermHints) {
    if (csTermHints.isEmpty) return '';

    return '아래는 이 문제 맥락에서 자주 등장하는 전공 용어입니다. 발음이 비슷한 일반 단어로 '
        '오인식되지 않도록 이 목록을 참고해 전사하세요: ${csTermHints.join(', ')}';
  }
}
