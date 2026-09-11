import 'package:flutter/material.dart';
import 'package:hontudy/presentation/views/route/nav_item.dart';

import '../../core/theme/context_theme_extension.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(99),
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
          NavItem(icon: Icons.home_outlined, label: '홈', isSelected: currentIndex == 0, onTap: () {}),
          NavItem(icon: Icons.menu_book_outlined, label: '노트', isSelected: currentIndex == 1, onTap: () {}),
          NavItem(icon: Icons.person_outline_rounded, label: '프로필', isSelected: currentIndex == 2, onTap: () {})
        ],
      ),
    );
  }
}
