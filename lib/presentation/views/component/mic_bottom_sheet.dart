import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;

class MicBottomSheet extends StatefulWidget {
  const MicBottomSheet({super.key});

  @override
  MicBottomSheetState createState() => MicBottomSheetState();
}

class MicBottomSheetState extends State<MicBottomSheet> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';

  String _confirmedText = '';

  @override
  void initState() {
    super.initState();

    _speech = stt.SpeechToText();
    _startListening();
  }

  Future<void> _startListening() async {
    final available = await _speech.initialize(
      onStatus: (val) => print('status: $val'),
      onError: (val) => print('error: $val'),
    );
    if (available) {
      setState(() => _isListening = true);
      final systemLocale = await _speech.systemLocale();
      _speech.listen(
        onResult: (result) => setState(() {
          final live = _confirmedText.isEmpty
              ? result.recognizedWords
              : '$_confirmedText ${result.recognizedWords}';
          _text = live;

          if (result.finalResult) {
            _confirmedText = live;
          }
        }),
        listenOptions: stt.SpeechListenOptions(
          localeId: systemLocale?.localeId,
          listenMode: stt.ListenMode.dictation,
          listenFor: const Duration(seconds: 60),
          pauseFor: const Duration(seconds: 5),
        ),
      );
    }
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    Navigator.pop(context, _text);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Expanded(child: _WaveFormBars()),
            SizedBox(
              height: 15,
            ),
            Expanded(child: Text('듣고 있어요...')),
            Expanded(
              child: MicButton(
                onTap: () {
                  _stopListening();
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Text(
                '눌러서 인식 종료',
                style: context.captionLarge,
              ),
            ),
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

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(baseHeights.length, (i) {
            final distance = (position - i).abs();

            final t = (1 - distance / _falloffWidth).clamp(0.0, 1.0);

            return waveBar(
              height: baseHeights[i] * (1 + 0.5 * t),
              color: Color.lerp(inactiveColor, activeColor, t)!,
            );
          }),
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
