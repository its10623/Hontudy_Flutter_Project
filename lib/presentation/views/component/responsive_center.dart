import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/app_layout.dart';
import 'package:hontudy/presentation/views/component/app_background.dart';

class ResponsiveCenter extends StatelessWidget {
  final Widget child;

  const ResponsiveCenter({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppLayout.maxContentWidth,
          ),
          child: child,
        ),
      ),
    );
  }
}
