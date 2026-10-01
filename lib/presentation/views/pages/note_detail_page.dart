import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/app_colors.dart';
import 'package:hontudy/presentation/views/component/chat/mic_bottom_sheet.dart';
import 'package:hontudy/presentation/views/component/choice_chip_widget.dart';
import 'package:hontudy/presentation/views/component/primary_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/theme/context_theme_extension.dart';
import '../../core/theme/text_type.dart';
import '../component/chip_widget.dart';
import '../route/bottom_nav_bar.dart';

class NoteDetailPage extends StatefulWidget {
  const NoteDetailPage({super.key});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  final PageController _controller = PageController(
    viewportFraction: 0.8, // 화면의 80% 크기로 페이지 설정
  );
  final savedQuiz = 14;
  final wrongAnswer = 9;
  final mainTopic = '네트워크';
  final secondaryTopic = '전송 계층';
  final List<List<dynamic>> wrongQuiz = [
    ['SO_REUSEADDR로 포트를 즉시 재사용하는 이유', 3],
    ['개방 주소법에서 클러스터링이 생기는 이유', 5],
    ['은행원 알고리즘의 안전 상태 판단 기준', 7],
    ['은행원 알고리즘의 안전 상태 판단 기준', 7],
    ['은행원 알고리즘의 안전 상태 판단 기준', 7],
    ['은행원 알고리즘의 안전 상태 판단 기준', 7],
    ['은행원 알고리즘의 안전 상태 판단 기준', 7],
    ['은행원 알고리즘의 안전 상태 판단 기준', 7],
  ];
  final bool isChecked = false;
  final List<List<dynamic>> quizzes = [
    [
      'TCP/UDP 특성',
      2,
      'TCP와 UDP의 핵심적인 차이점을 신뢰성과 데이터 전송 방식 관점에서 비교하고, 각각에 적합한 서비스 예시를 드시오.',
      'TCP는 연결지향이라 신뢰성이 높고 패킷이 유실되면 다시 보내줍니다. HTTP 통신에 씁니다. UDP는 비연결형이라 속도가 빠른 대신 패킷이 유실될 수 있습니다. 영상 스트리밍에 씁니다.',
      5,
      1,
      /*'TCP (Transmission Control Protocol): 연결 지향적 프로토콜로, 데이터의 순서와 수신 여부를 확인하여 신뢰성 있는 전송을 보장합니다. (예시: 웹 페이지 로딩(HTTP), 파일 전송(FTP), 이메일)\n\nUDP (User Datagram Protocol): 비연결형 프로토콜로, 수신 확인이나 순서 보장을 하지 않아 신뢰성은 낮지만 오버헤드가 적고 전송 속도가 빠릅니다. (예시: 실시간 화상 회의, 온라인 게임, DNS 질의)',
      '정답'*/
    ],
    [
      'TCP 연결 관리',
      4,
      'TCP 연결 종료 과정(4-Way Handshake)에서 TIME_WAIT 상태가 존재하는 두 가지 주요 이유는 무엇입니까?',
      '클라이언트가 강제로 종료했을 때 서버가 바로 꺼지는 걸 막으려고 대기하는 상태입니다.',
      3,
      2,
      /*'1. 지연된 패킷의 처리: 네트워크 상에서 길을 잃고 늦게 도착하는 잉여 패킷이 새로 맺어진 연결에 섞여 들어가 데이터 무결성을 해치는 것을 방지합니다.\n2. 안전한 연결 종료 보장: 서버가 클라이언트의 마지막 ACK를 받지 못해 FIN을 재전송할 경우를 대비하여, 클라이언트가 일정 시간 동안 소켓을 닫지 않고 대기하며 응답을 처리할 수 있게 합니다.',
      '오답'*/
    ],
    [
      '소켓 프로그래밍',
      4,
      '서버 소켓 프로그래밍 시 SO_REUSEADDR 옵션을 활성화하는 구체적인 목적은 무엇입니까?',
      '서버 비정상 종료하고 다시 켤 때 TIME_WAIT 걸려있어서 bind 에러 나는거 무시하고 바로 포트 재사용하려고 켭니다.',
      3,
      1,
      /*'서버 프로세스가 비정상 종료되거나 재시작될 때, 기존에 사용하던 포트가 커널에 의해 TIME_WAIT 상태로 묶여 있어 즉시 bind()를 할 수 없는 문제(주소 할당 에러)를 해결하기 위함입니다. 이 옵션을 켜면 TIME_WAIT 상태의 포트라도 즉시 재바인딩하여 서버를 대기 상태로 만들 수 있습니다.',
      '정답'*/
    ],
    [
      '다중화/역다중화',
      6,
      '전송 계층의 핵심 기능 중 하나인 다중화(Multiplexing)와 역다중화(Demultiplexing)가 무엇인지 포트(Port) 번호와 연관 지어 설명하시오.',
      '다중화는 여러 데이터를 하나의 포트로 합쳐서 보내는 거고, 역다중화는 받은 데이터를 IP 주소를 보고 여러 개로 쪼개는 겁니다.',
      4,
      2,
      /*'다중화: 송신 측 호스트에서 실행 중인 여러 프로세스(소켓)들이 만들어낸 데이터들을 모아, 전송 계층 헤더(출발지/목적지 포트 번호 등)를 붙여 하나의 캡슐로 만든 뒤 네트워크 계층으로 내려보내는 과정입니다.\n\n역다중화: 수신 측 호스트가 받은 패킷의 헤더를 분석하여, 목적지 포트 번호와 정확히 일치하는 실행 중인 프로세스(소켓)로 데이터를 분배해 주는 과정입니다.',
      '오답'*/
    ],
    [
      'TCP 제어 메커니즘',
      8,
      'TCP가 송신자의 데이터 전송 속도를 제어하는 기법 두 가지(흐름 제어, 혼잡 제어)의 대상을 비교하여 설명하시오.',
      '흐름 제어는 받는 사람의 버퍼 상태에 맞춰서 보내는 양을 조절하는 거고, 혼잡 제어는 네트워크 라우터 자체가 붐빌 때 윈도우 사이즈를 줄여서 조절하는 겁니다.',
      5,
      1,
      /*'흐름 제어 (Flow Control): 수신자가 데이터를 처리하는 속도를 초과하지 않도록 송신자의 전송 속도를 조절하는 기법입니다. 수신자가 자신의 가용 버퍼 크기를 송신자에게 알려주어 제어합니다.\n\n혼잡 제어 (Congestion Control): 네트워크 전체의 트래픽 혼잡도를 고려하여 송신자의 전송 속도를 제어하는 기법입니다. 네트워크가 붐빌 때 패킷 손실이 발생하는 것을 감지하고 전송량을 줄입니다.',
      '정답'*/
    ],
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
          child: const SafeArea(
            child: BottomNavBar(
              currentIndex: 1,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: context.colors.surface,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mainTopic,
              style: TextType.titleLarge.copyWith(letterSpacing: -0.5),
            ),
            Text(
              '$savedQuiz문제 · 오답 $wrongAnswer · $secondaryTopic',
              style: context.captionMedium,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChoiceChipWidget(savedQuiz: savedQuiz, wrongAnswer: wrongAnswer),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                ),
                child: _NoteQuizCardCarousel(
                  controller: _controller,
                  quizzes: quizzes,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: quizzes.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 6,
                    dotWidth: 6,
                    activeDotColor: context.colors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoteQuizCardCarousel extends StatefulWidget {
  final List<List<dynamic>> quizzes;
  final PageController _controller;

  const _NoteQuizCardCarousel({
    super.key,
    required this._controller,
    required this.quizzes,
  });

  @override
  State<_NoteQuizCardCarousel> createState() => _NoteQuizCardCarouselState();
}

class _NoteQuizCardCarouselState extends State<_NoteQuizCardCarousel> {
  final Set<int> _checkedIndices = {};

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget._controller,
      clipBehavior: Clip.none,
      itemCount: widget.quizzes.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: widget._controller,
          builder: (context, child) {
            double distance = 0;
            if (widget._controller.hasClients &&
                widget._controller.position.haveDimensions) {
              distance = (widget._controller.page! - index).abs().clamp(
                0.0,
                1.0,
              );
            }
            final scale = 1 - (distance * 0.15);
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: _NoteQuizCard(
            quizzes: widget.quizzes[index],
            isChecked: _checkedIndices.contains(index),
            onCheckedChanged: (checked) {
              setState(() {
                if (checked) {
                  _checkedIndices.add(index);
                } else {
                  _checkedIndices.remove(index);
                }
              });
            },
          ),
        );
      },
    );
  }
}

class _NoteQuizCard extends StatefulWidget {
  final List<dynamic> quizzes;
  final bool isChecked;
  final ValueChanged<bool> onCheckedChanged;

  const _NoteQuizCard({
    super.key,
    required this.quizzes,
    required this.isChecked,
    required this.onCheckedChanged,
  });

  @override
  State<_NoteQuizCard> createState() => _NoteQuizCardState();
}

class _NoteQuizCardState extends State<_NoteQuizCard>
    with SingleTickerProviderStateMixin {
  static const double _flipDistance = 200;

  double _dragOffset = 0;

  late final AnimationController _snapController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );
  double _snapStart = 0;
  double _snapTarget = 0;

  @override
  void dispose() {
    _snapController.dispose();
    super.dispose();
  }

  void _snapTo(double target) {
    _snapStart = _dragOffset;
    _snapTarget = target;
    _snapController.forward(from: 0).then((_) {
      setState(() => _dragOffset = target);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragUpdate: (details) {
        setState(() {
          _dragOffset += details.primaryDelta ?? 0;
        });
      },
      onVerticalDragEnd: (details) {
        final velocity = details.primaryVelocity ?? 0;
        final pastHalfway = _dragOffset.abs() > _flipDistance / 2;
        final shouldFlip = velocity.abs() > 300 || pastHalfway;
        if (shouldFlip) {
          final sign = _dragOffset == 0
              ? (velocity < 0 ? -1 : 1)
              : (_dragOffset < 0 ? -1 : 1);
          _snapTo(_flipDistance * sign);
        } else {
          _snapTo(0);
        }
      },
      child: AnimatedBuilder(
        animation: _snapController,
        builder: (context, child) {
          final offset = _snapController.isAnimating
              ? lerpDouble(_snapStart, _snapTarget, _snapController.value)!
              : _dragOffset;
          final angle = (offset / _flipDistance).clamp(-1.0, 1.0) * pi;
          final showingBack = angle.abs() > pi / 2;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(angle),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                color: context.colors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: context.colors.outline.withAlpha(150),
                    blurRadius: 30,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: showingBack
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateX(pi),
                      child: _buildBackContent(context),
                    )
                  : _buildFrontContent(context),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFrontContent(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChipWidget(label: widget.quizzes[0]),
              Text(
                '${widget.quizzes[1]}일 전',
                style: context.captionMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Text(
          'Q. ${widget.quizzes[2]}',
          style: TextType.titleMedium,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.colors.outlineVariant.withAlpha(100),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '내 답',
                style: TextType.captionSmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colors.outline,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                '${widget.quizzes[3]}',
                style: TextType.captionMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.colors.outline,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            ChipWidget(
              label: '오답 ${widget.quizzes[4]}회',
              backgroundColor: AppColors.wrongSurface,
              textColor: AppColors.wrong,
            ),
            const SizedBox(
              width: 6,
            ),
            ChipWidget(
              label: '정답 ${widget.quizzes[5]}회',
            ),
          ],
        ),
        const Spacer(),
        PrimaryButton(
          onPressed: () => _snapTo(_flipDistance),
          text: '해설 다시 보기',
          color: ButtonColor.primary,
        ),
        Center(
          child: GestureDetector(
            onTap: () => widget.onCheckedChanged(!widget.isChecked),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: widget.isChecked,
                  onChanged: (value) => widget.onCheckedChanged(value ?? false),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  side: BorderSide(color: context.colors.outline, width: 1.5),
                ),
                Text(
                  '이 문제 다시 출제',
                  style: context.captionLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('해설', style: TextType.titleMedium),
        const SizedBox(height: 12),
        Text(
          // TODO: 실제 해설 데이터 연동 전까지는 내 답으로 대체 표시
          '${widget.quizzes[3]}',
          style: context.captionMedium,
        ),
        const Spacer(),
        PrimaryButton(
          onPressed: () => _snapTo(0),
          text: '문제로 돌아가기',
          color: ButtonColor.surface,
        ),
      ],
    );
  }
}
