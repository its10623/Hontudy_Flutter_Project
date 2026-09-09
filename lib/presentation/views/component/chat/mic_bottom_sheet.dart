import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/app_colors.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/views/component/app_divider.dart';
import 'package:hontudy/presentation/views/component/primary_button.dart';

class MicBottomSheet extends StatefulWidget {
  const MicBottomSheet({super.key});

  @override
  MicBottomSheetState createState() => MicBottomSheetState();
}

class MicBottomSheetState extends State<MicBottomSheet> {
  final String _text =
      'TCP는 연결형이라 신뢰성이 있고 순서를 보장해요. UDP는 비연결형이라 유디피 속도가 빠릅니다. 영상 스트리밍이나 게임에 쓰여요.';
  bool _isListening = false;
  final recordTime = '0:14';
  final textController = TextEditingController(
    text:
        'TCP는 연결형이라 신뢰성이 있고 순서를 보장해요. UDP는 비연결형이라 유디피 속도가 빠릅니다. 영상 스트리밍이나 게임에 쓰여요.',
  );
  int missNum = 1;

  @override
  void initState() {
    super.initState();
    _isListening = true;
  }

  void _stopListening() {
    _isListening = false;
    setState(() {});
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _isListening ? 250 : 400,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (_isListening) ...[
              SizedBox(height: 55, child: _WaveFormBars()),
              Text('듣고 있어요...'),
              MicButton(
                onTap: () {
                  _stopListening();
                },
              ),
              Text(
                '눌러서 인식 종료',
                style: context.captionLarge,
              ),
            ] else ...[
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '이렇게 말씀하셨어요',
                            style: context.textStyles.headlineSmall,
                          ),
                          Text(
                            '틀린 부분은 눌러서 직접 수정 할 수 있어요',
                            style: context.captionLarge,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: context.colors.surfaceContainerHighest
                              .withAlpha(50),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(
                          recordTime,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.primaryContainer.withAlpha(20),
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(16, 16),
                      ),
                      border: BoxBorder.all(
                        color: context.colors.primary,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: textController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: _text.isEmpty ? '변환된 텍스트가 없습니다.' : null,
                          ),
                        ),
                        AppDivider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.circle,
                              size: 8,
                              color: AppColors.textHighlightAmber,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '인식이 불확실한 구간 $missNum곳',
                              style: context.captionLarge.copyWith(
                                color: AppColors.textHighlightAmber,
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                '전체 지우기',
                                style: context.captionLarge.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          onPressed: () {},
                          text: '다시 녹음',
                          color: ButtonColor.surface,
                          icon: Icons.mic_none_rounded,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: PrimaryButton(
                          onPressed: () {},
                          text: '내용 수정',
                          color: ButtonColor.primary,
                          icon: Icons.create_outlined,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          onPressed: () {},
                          text: '이 답으로 제출',
                          color: ButtonColor.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class MicButton extends StatelessWidget {
  final VoidCallback onTap;

  const MicButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Ink(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: context.colors.primaryContainer.withAlpha(100),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.stop_circle_rounded,
            size: 60,
            color: context.colors.primary,
          ),
        ),
      ),
    );
  }
}

class _WaveFormBars extends StatefulWidget {
  @override
  _WaveFormBarsState createState() => _WaveFormBarsState();
}

class _WaveFormBarsState extends State<_WaveFormBars>
    with SingleTickerProviderStateMixin {
  static const _barCount = 9;
  static const _cycleDuration = Duration(seconds: 2);

  static const _falloffWidth = 3.0;

  late final _controller = AnimationController(
    vsync: this,
    duration: _cycleDuration,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const List<double> baseHeights = [20, 30, 15, 35, 25, 35, 15, 30, 20];
    final inactiveColor = context.colors.onSurfaceVariant.withAlpha(50);
    final activeColor = context.colors.primary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final position = _controller.value * _barCount;

        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(baseHeights.length, (i) {
              final distance = (position - i).abs();
              final t = (1 - distance / _falloffWidth).clamp(0.0, 1.0);

              return waveBar(
                height: baseHeights[i] * (1 + 0.5 * t),
                color: Color.lerp(inactiveColor, activeColor, t)!,
              );
            }),
          ),
        );
      },
    );
  }

  Widget waveBar({required double height, required Color color}) {
    return Container(
      margin: const EdgeInsets.all(2),
      width: 5,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

enum ButtonColor { primary, surface }
