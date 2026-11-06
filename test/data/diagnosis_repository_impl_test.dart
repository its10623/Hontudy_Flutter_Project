import 'package:flutter_test/flutter_test.dart';
import 'package:hontudy/data/dto/diagnosis_profile_dto.dart';
import 'package:hontudy/data/repositoriesImpl/diagnosis_repository_impl.dart';
import 'package:hontudy/domain/exceptions.dart';
import 'package:hontudy/domain/models/diagnosis_profile.dart';
import 'package:hontudy/domain/models/diagnosis_turn.dart';
import 'package:hontudy/domain/repositories/diagnosis_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../fixtures/auth_fixtures.dart';
import '../fixtures/diagnosis_fixtures.dart';
import '../mock/mock_ai_functions_service.dart';
import '../mock/mock_auth_service.dart';
import '../mock/mock_firestore_service.dart';

void main() {
  late MockAiFunctionsService aiService;
  late MockAuthService authService;
  late MockFirestoreService firestoreService;
  late DiagnosisRepository diagnosisRepository;

  /// registerFallbackValue 등록
  /// 직접 만든 타입에 any()와 captureAny()를 사용할 경우 등록 해야함
  setUpAll(() {
    registerFallbackValue(
      DiagnosisProfileDto(
        difficultyScore: 0,
        purposeTags: const [],
        weakAreas: const [],
        timestamp: DateTime(2000),
      ),
    );
  });

  setUp(() {
    aiService = MockAiFunctionsService();
    authService = MockAuthService();
    firestoreService = MockFirestoreService();
    diagnosisRepository = DiagnosisRepositoryImpl(
      firestore: firestoreService,
      auth: authService,
      ai: aiService,
    );
  });

  final history = [
    const DiagnosisAnswer(questionText: '1+1은?', answerText: '2'),
  ];

  // 프롬프트 내용과 무관하게 이 JSON을 응답한다
  void stubAiResponse(Map<String, dynamic> json) {
    when(
      () => aiService.sendPrompt(messages: any(named: 'messages')),
    ).thenAnswer((_) async => json);
  }

  String label(Object? value) => value is String ? '"$value"' : '$value';

  test('진단 프로필을 저장한다', () async {
    when(() => authService.requireUid()).thenReturn(testUid);
    final profile = testProfile();

    when(
      () => firestoreService.saveDiagnosisProfile(testUid, any()),
    ).thenAnswer((_) async {});

    final result = await diagnosisRepository.saveDiagnosisProfile(profile);

    expect(result.exceptionOrNull(), isNull);

    final verification = verify(
      () => firestoreService.saveDiagnosisProfile(testUid, captureAny()),
    );
    verification.called(1);
    final captureDto = verification.captured.single as DiagnosisProfileDto;
    expect(captureDto.background, profile.background);
    expect(captureDto.difficultyScore, profile.difficultyScore);
    expect(captureDto.purposeTags, profile.purposeTags);
    expect(captureDto.weakAreas, profile.weakAreas);
    expect(captureDto.timestamp, profile.timestamp);
  });

  group('requestDiagnosisClassification', () {
    Future<Result<DiagnosisResult>> classify(Map<String, dynamic> json) {
      stubAiResponse(json);
      return diagnosisRepository.requestDiagnosisClassification(history);
    }

    void testMissingField(String field) {
      test('필드 없으면 실패한다', () async {
        final json = Map.of(classificationJson())..remove(field);
        final result = await classify(json);
        expect(result.exceptionOrNull(), isA<UnknownException>());
      });
    }

    test('정상 응답이면 모든 필드를 옮긴다', () async {
      final classification = (await classify(
        classificationJson(),
      )).getOrThrow();

      expect(
        classification.reasoning,
        '자료구조와 네트워크 기초는 알고 있지만 데이터베이스 설계 경험은 부족해 보여요.'
        ' 실무에 바로 쓸 수 있는 문제를 원하셔서 중간 난이도로 시작해요.',
      );
      expect(classification.profile.background, '전공자');
      expect(classification.backgroundDetail, '컴퓨터공학 전공, 백엔드 인턴 3개월');
      expect(classification.profile.difficultyScore, 3);
      expect(classification.profile.purposeTags, ['실무 역량 강화', '취업·이직 준비']);
      expect(classification.profile.weakAreas, ['네트워크', '데이터베이스']);
    });

    group('difficulty_score', () {
      const convertCases = [('3', 3), (3.6, 4)];
      const failureCases = ['abc', 6, 0, null, ''];

      for (final (input, expected) in convertCases) {
        test('${label(input)} → $expected', () async {
          final classification = (await classify(
            classificationJson(difficultyScore: input),
          )).getOrThrow();

          expect(classification.profile.difficultyScore, expected);
        });
      }

      for (final input in failureCases) {
        test('${label(input)}이면 실패한다', () async {
          final result = await classify(
            classificationJson(difficultyScore: input),
          );

          expect(result.exceptionOrNull(), isA<UnknownException>());
        });
      }

      testMissingField('difficulty_score');
    });

    group('background', () {
      const cases = [
        ('전공자', '전공자'),
        ('비전공자', '비전공자'),
        ('고졸', null),
        ('', null),
        (' 전공자 ', '전공자'),
        (null, null),
        (1, null),
      ];

      for (final (input, expected) in cases) {
        test('${label(input)} → ${label(expected)}', () async {
          final classification = (await classify(
            classificationJson(background: input),
          )).getOrThrow();

          expect(classification.profile.background, expected);
        });
      }
    });

    group('purpose_tags', () {
      const cases = [
        (['실무 역량 강화', '면접 준비'], ['실무 역량 강화']),
        (['실무 역량 강화', '실무 역량 강화'], ['실무 역량 강화']),
        (['면접 직전 대비', '입문 학습'], ['면접 직전 대비', '입문 학습']),
        ('실무 역량 강화', []),
        (null, []),
        (['기초'], []),
      ];

      for (final (input, expected) in cases) {
        test('${label(input)} → ${label(expected)}', () async {
          final classification = (await classify(
            classificationJson(purposeTags: input),
          )).getOrThrow();

          expect(classification.profile.purposeTags, expected);
        });
      }
    });

    group('weak_areas', () {
      const cases = [
        (
          ['네트워크', '데이터베이스', '자료구조'],
          ['네트워크', '데이터베이스', '자료구조'],
        ),
        // weak_areas는 take(3)로 3개만 남긴다.
        (
          ['네트워크', '데이터베이스', '자료구조', '알고리즘'],
          ['네트워크', '데이터베이스', '자료구조'],
        ),
        (
          ['네트워크', '네트워크', '자료구조', '알고리즘'],
          ['네트워크', '자료구조', '알고리즘'],
        ),
        (
          ['임베디드 소프트웨어', '데이터베이스', '운영체제', '객체지향 프로그래밍'],
          ['데이터베이스', '운영체제', '객체지향 프로그래밍'],
        ),
        (
          ['임베디드 소프트웨어', '운영체제', '객체지향 프로그래밍'],
          ['운영체제', '객체지향 프로그래밍'],
        ),
        (
          ['데이터베이스', '데이터베이스', '객체지향 프로그래밍'],
          ['데이터베이스', '객체지향 프로그래밍'],
        ),
        ('네트워크', []),
        (null, []),
        (['파이썬'], []),
      ];

      for (final (input, expected) in cases) {
        test('${label(input)} → ${label(expected)}', () async {
          final classification = await classify(
            classificationJson(weakAreas: input),
          ).getOrThrow();
          expect(classification.profile.weakAreas, expected);
        });
      }
    });
    group('reasoning', () {
      const cases = [
        null,
        ['필드 없음'],
        3,
      ];
      for (final input in cases) {
        test('${label(input)} 이면 실패한다', () async {
          final result = (await classify(
            classificationJson(reasoning: input),
          ));
          expect(result.exceptionOrNull(), isA<UnknownException>());
        });
      }

      testMissingField('reasoning');
    });
  });

  group('requestDiagnosisTurn', () {
    Future<Result<DiagnosisTurn>> requestTurn(Map<String, dynamic> json) {
      stubAiResponse(json);
      return diagnosisRepository.requestDiagnosisTurn(history);
    }

    test('정상 응답이면 모든 필드를 옮긴다', () async {
      final turn = await requestTurn(diagnosisTurnJson()).getOrThrow();

      expect(turn.nextAction, DiagnosisNextAction.continueDiagnosis);
      expect(turn.questionText, '개발 공부는 얼마나 해보셨나요?');
      expect(
        turn.diagnosisContent,
        const DiagnosisContent.singleChoiceList(
          options: ['처음이에요', '1년 미만', '1년 이상'],
        ),
      );
    });

    group('next_action', () {
      const successCases = [
        ('continue_diagnosis', DiagnosisNextAction.continueDiagnosis),
        ('ready_to_classify', DiagnosisNextAction.readyToClassify),
        ('off_topic', DiagnosisNextAction.offTopic),
        ('user_requested_problem', DiagnosisNextAction.userRequestedProblem),
      ];
      const failureCases = [
        'finish',
        null,
        '',
        3,
        ' off_topic',
        'continue_ diagnosis',
      ];
      for (final (input, expected) in successCases) {
        test('${label(input)} → ${label(expected)}', () async {
          final turn = await requestTurn(
            diagnosisTurnJson(nextAction: input),
          ).getOrThrow();

          expect(turn.nextAction, expected);
        });
      }

      for (final input in failureCases) {
        test('${label(input)} 이면 실패한다', () async {
          final result = await requestTurn(
            diagnosisTurnJson(nextAction: input),
          );

          expect(result.exceptionOrNull(), isA<UnknownException>());
        });
      }

      test('필드 없으면 실패한다', () async {
        final json = Map.of(diagnosisTurnJson())..remove('next_action');

        final result = await requestTurn(json);
        expect(result.exceptionOrNull(), isA<UnknownException>());
      });
    });

    group('widget_type', () {
      const cases = [
        ('free_text_input', null, DiagnosisContent.freeTextInput()),
        ('free_text_input', [1, 2], DiagnosisContent.freeTextInput()),
        (
          'choice_chips',
          {
            'options': ['네트워크', '자료구조', '데이터베이스', '운영체제'],
          },
          DiagnosisContent.choiceChips(
            options: ['네트워크', '자료구조', '데이터베이스', '운영체제'],
          ),
        ),
        (
          'single_choice_list',
          {
            'options': ['네트워크', '자료구조', '데이터베이스', '운영체제'],
          },
          DiagnosisContent.singleChoiceList(
            options: ['네트워크', '자료구조', '데이터베이스', '운영체제'],
          ),
        ),
      ];
      for (final (type, content, expected) in cases) {
        test(
          'type:${label(type)}와 content:${label(content)} 이면 ${label(expected.widgetType)}로 옮긴다',
          () async {
            final turn = await requestTurn(
              diagnosisTurnJson(widgetType: type, widgetContent: content),
            ).getOrThrow();

            expect(turn.diagnosisContent, expected);
          },
        );
      }

      test(
        'type: "summary_confirm"이면 summary_text와 reasoning을 옮긴다',
        () async {
          final turn = await requestTurn(
            diagnosisTurnJson(
              widgetType: 'summary_confirm',
              widgetContent: {'summary_text': '진단 요약됨'},
              reasoning: '요약 근거 문장',
            ),
          ).getOrThrow();

          expect(
            turn.diagnosisContent,
            const DiagnosisContent.summaryConfirm(
              summaryText: '진단 요약됨',
              reasoningText: '요약 근거 문장',
            ),
          );
        },
      );

      group('widgetTypeFailure', () {
        const cases = ['slider', null, ''];
        for (final input in cases) {
          test('${label(input)}이면 실패한다', () async {
            final result = await requestTurn(
              diagnosisTurnJson(widgetType: input),
            );

            expect(result.exceptionOrNull(), isA<UnknownException>());
          });
        }
      });
    });

    group('widgetContent', () {
      const cases = [
        null,
        {},
        {'options': '네트워크'},
        {
          'options': [1, 2, 3, 4],
        },
        ['네트워크', '데이터베이스', '자료구조'],
      ];
      for (final input in cases) {
        test('${label(input)}이면 실패한다', () async {
          final result = await requestTurn(
            diagnosisTurnJson(widgetType: 'choice_chips', widgetContent: input),
          );

          expect(result.exceptionOrNull(), isA<UnknownException>());
        });
      }

      test('"summary_confirm"인데 summary_text가 없으면 실패한다', () async {
        final result = await requestTurn(
          diagnosisTurnJson(widgetType: 'summary_confirm', widgetContent: {}),
        );

        expect(result.exceptionOrNull(), isA<UnknownException>());
      });

      test('"summary_confirm"인데 reasoning이 없으면 실패한다', () async {
        final result = await requestTurn(
          diagnosisTurnJson(
            widgetType: 'summary_confirm',
            widgetContent: {'summary_text': '진단 요약됨'},
            reasoning: null,
          ),
        );

        expect(result.exceptionOrNull(), isA<UnknownException>());
      });

      test('보기형 위젯은 reasoning이 없어도 성공한다', () async {
        final result = await requestTurn(
          diagnosisTurnJson(widgetType: 'choice_chips', reasoning: null),
        );

        expect(result.exceptionOrNull(), isNull);
      });
    });
    group('questionText', () {
      const cases = [
        ('문제 출제', '문제 출제'),
        // 범위 밖 답변일 때 프롬프트는 빈 문자열을 요청한다.
        ('', ''),
      ];
      const failureCases = [
        null,
        1,
        ['문제 출제'],
      ];

      for (final (input, expected) in cases) {
        test('${label(input)}이면 ${label(expected)}로 옮긴다', () async {
          final turn = await requestTurn(
            diagnosisTurnJson(questionText: input),
          ).getOrThrow();

          expect(turn.questionText, expected);
        });
      }

      for (final input in failureCases) {
        test('${label(input)}이면 실패한다', () async {
          final result = await requestTurn(
            diagnosisTurnJson(questionText: input),
          );

          expect(result.exceptionOrNull(), isA<UnknownException>());
        });
      }

      test('필드 없으면 실패한다', () async {
        final json = Map.of(diagnosisTurnJson())..remove('question_text');

        final result = await requestTurn(json);
        expect(result.exceptionOrNull(), isA<UnknownException>());
      });
    });
  });

  group('diagnosisProfile', () {
    setUp(() {
      when(() => authService.requireUid()).thenReturn(testUid);
    });

    test('진단 프로필을 가져온다', () async {
      when(
        () => firestoreService.fetchDiagnosisProfile(testUid),
      ).thenAnswer((_) async => testProfileDto());
      final (profile,) = await diagnosisRepository
          .fetchDiagnosisProfile()
          .getOrThrow();

      expect(profile, testProfile());
    });

    test('진단 프로필이 없으면 null을 가져온다', () async {
      when(
        () => firestoreService.fetchDiagnosisProfile(testUid),
      ).thenAnswer((_) async => null);
      final result = await diagnosisRepository.fetchDiagnosisProfile();

      expect(result.exceptionOrNull(), isNull);
      expect(result.getOrThrow().$1, isNull);
    });

    test('진단 프로필 기록을 조회한다', () async {
      when(
        () => firestoreService.fetchDiagnosisProfileHistory(testUid),
      ).thenAnswer(
        (_) async => [
          testProfileDto(difficultyScore: 1),
          testProfileDto(difficultyScore: 5),
        ],
      );
      final history = await diagnosisRepository
          .fetchDiagnosisProfileHistory()
          .getOrThrow();

      expect(history, [
        testProfile(difficultyScore: 1),
        testProfile(difficultyScore: 5),
      ]);
    });

    test('진단 프로필 기록이 없으면 빈 리스트를 가져온다', () async {
      when(
        () => firestoreService.fetchDiagnosisProfileHistory(testUid),
      ).thenAnswer((_) async => []);
      final result = await diagnosisRepository.fetchDiagnosisProfileHistory();

      expect(result.exceptionOrNull(), isNull);
      expect(result.getOrThrow(), isEmpty);
    });

    test('진단 프로필을 삭제한다', () async {
      when(
        () => firestoreService.deleteDiagnosisProfileHistory(testUid),
      ).thenAnswer((_) async {});
      final result = await diagnosisRepository.deleteDiagnosisProfile();

      expect(result.exceptionOrNull(), isNull);

      final verification = verify(
        () => firestoreService.deleteDiagnosisProfileHistory(
          testUid,
        ),
      );

      verification.called(1);
    });
  });
}
