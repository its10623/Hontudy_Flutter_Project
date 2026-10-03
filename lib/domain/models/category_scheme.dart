class MainCategory {
  final String name;
  final List<String> topics;

  const MainCategory({
    required this.name,
    required this.topics,
  });
}

class CategoryScheme {
  CategoryScheme._();

  static const List<MainCategory> mainCategories = [
    MainCategory(
      name: '자료구조',
      topics: ['배열/리스트', '스택/큐', '트리', '그래프', '해시테이블'],
    ),
    MainCategory(
      name: '알고리즘',
      topics: ['정렬', '탐색', '재귀', '동적 계획법', '그리디'],
    ),
    MainCategory(
      name: '운영체제',
      topics: ['프로세스/스레드', '스케줄링', '메모리 관리', '동기화', '데드락'],
    ),
    MainCategory(
      name: '네트워크',
      topics: ['OSI 7계층', 'TCP/UDP', 'HTTP', 'DNS', '소켓'],
    ),
    MainCategory(
      name: '데이터베이스',
      topics: ['SQL', '정규화', '인덱스', '트랜잭션', 'NoSQL'],
    ),
    MainCategory(
      name: '컴퓨터 구조',
      topics: ['CPU', '메모리 계층', '캐시', '명령어 파이프라이닝', '레지스터'],
    ),
    MainCategory(
      name: '소프트웨어 공학',
      topics: ['개발 방법론', '요구사항 분석', '테스트', '디자인 패턴', '형상 관리'],
    ),
    MainCategory(
      name: '객체지향 프로그래밍',
      topics: ['클래스/객체', '캡슐화', '상속', '다형성', 'SOLID'],
    ),
    MainCategory(
      name: '인공지능',
      topics: ['머신러닝 기초', '지도/비지도 학습', '신경망', '자연어 처리', '모델 평가'],
    ),
    MainCategory(
      name: '보안',
      topics: ['암호화', '인증/인가', '웹 보안', '네트워크 보안', '시큐어 코딩'],
    ),
  ];
}
