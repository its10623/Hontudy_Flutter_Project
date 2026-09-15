import 'package:flutter/material.dart';

import '../../core/theme/context_theme_extension.dart';
import '../../core/theme/text_type.dart';

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
          _NavItem(icon: Icons.home_outlined, label: '홈', isSelected: currentIndex == 0, onTap: () {}),
          _NavItem(icon: Icons.menu_book_outlined, label: '노트', isSelected: currentIndex == 1, onTap: () {}),
          _NavItem(icon: Icons.person_outline_rounded, label: '프로필', isSelected: currentIndex == 2, onTap: () {})
        ],
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => widget.onTap,
        splashColor: context.colors.primaryContainer.withAlpha(100),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: 100,
          height: 60,
          decoration: BoxDecoration(
            color: widget.isSelected
                ? context.colors.primaryContainer.withAlpha(150)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: widget.isSelected
                    ? context.colors.primary
                    : context.colors.outline,
              ),
              Text(
                widget.label,
                style: widget.isSelected
                    ? TextType.captionLarge.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.w800,
                )
                    : TextType.captionLarge.copyWith(
                  color: context.colors.outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
