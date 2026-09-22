class MainCategory {
  final String name;
  final String shortLabel;
  final List<String> topics;

  const MainCategory({
    required this.name,
    required this.shortLabel,
    required this.topics,
  });
}

class CategoryScheme {
  CategoryScheme._();

  static const List<MainCategory> mainCategories = [
    MainCategory(
      name: '자료구조',
      shortLabel: '자료구조',
      topics: ['배열/리스트', '스택/큐', '트리', '그래프', '해시테이블'],
    ),
    MainCategory(
      name: '알고리즘',
      shortLabel: '알고리즘',
      topics: ['정렬', '탐색', '재귀', '동적 계획법', '그리디'],
    ),
    MainCategory(
      name: '운영체제',
      shortLabel: '운영체제',
      topics: ['프로세스/스레드', '스케줄링', '메모리 관리', '동기화', '데드락'],
    ),
    MainCategory(
      name: '네트워크',
      shortLabel: '네트워크',
      topics: ['OSI 7계층', 'TCP/UDP', 'HTTP', 'DNS', '소켓'],
    ),
    MainCategory(
      name: '데이터베이스',
      shortLabel: 'DB',
      topics: ['SQL', '정규화', '인덱스', '트랜잭션', 'NoSQL'],
    ),
    MainCategory(
      name: '컴퓨터구조',
      shortLabel: '컴구조',
      topics: ['CPU', '메모리 계층', '캐시', '명령어 파이프라이닝', '레지스터'],
    ),
    MainCategory(
      name: '디자인패턴',
      shortLabel: '디자인패턴',
      topics: ['싱글턴', '옵저버', '팩토리', 'MVC/MVVM', 'SOLID'],
    ),
  ];
}
