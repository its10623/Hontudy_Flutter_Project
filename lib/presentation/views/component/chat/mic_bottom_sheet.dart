import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';

class MicBottomSheet extends StatefulWidget {
  const MicBottomSheet({super.key});

  @override
  MicBottomSheetState createState() => MicBottomSheetState();
}

class MicBottomSheetState extends State<MicBottomSheet> {
  final String _text = '';
  bool _isListening = false;

  @override
  void initState() {
    _isListening = true;
    super.initState();
  }

  void _stopListening() {
    _isListening = false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _isListening ? 250 : 400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if(_isListening)...[
              SizedBox(height: 55, child: _WaveFormBars()),
              Text('듣고 있어요...'),
              MicButton(
                onTap: () {
                  _stopListening();
                  setState(() {

                  });
                },
              ),
              Text(
                '눌러서 인식 종료',
                style: context.captionLarge,
              ),
            ] else...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('이렇게 말씀하셨어요',style: context.textStyles.headlineSmall,),
                      Text(
                        '틀린 부분은 눌러서 직접 수정 할 수 있어요',
                        style: context.captionLarge,
                      ),
                    ],
                  ),
                  // TODO 녹음 시간 칩
                ],
              ),

            ]

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
