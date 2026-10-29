import 'package:flutter/material.dart';

import '../../core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';

import 'nav_item.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: AppShape.pill,
        boxShadow: [
          BoxShadow(
            color: context.colors.outline.withAlpha(50),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final (index, item) in navDestinations.indexed)
            NavItem(
              icon: item.icon,
              label: item.label,
              isSelected: currentIndex == index,
              onTap: () => onTap(index),
              horizontal: false,
            ),
        ],
      ),
    );
  }
}
