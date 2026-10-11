import 'dart:async';

import 'package:flutter/material.dart';

class ExitGuard extends StatefulWidget {
  final Widget child;

  const ExitGuard({super.key, required this.child});

  @override
  State<ExitGuard> createState() => _ExitGuardState();
}

class _ExitGuardState extends State<ExitGuard> {
  static const _window = Duration(seconds: 2);
  bool _canExit = false;
  Timer? _resetTimer;

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }

  void _handleBack() {
    setState(() => _canExit = true);
    _resetTimer?.cancel();
    _resetTimer = Timer(_window, () {
      if (mounted) setState(() => _canExit = false);
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('한 번 더 누르면 종료돼요'),
          duration: _window,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canExit,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _handleBack();
      },
      child: widget.child,
    );
  }
}
