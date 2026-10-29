import 'package:flutter/material.dart';

import '../../core/theme/context_theme_extension.dart';
import '../../core/theme/shape.dart';
import '../../core/theme/text_type.dart';

const navDestinations = [
  (icon: Icons.quiz_outlined, label: '문제풀이'),
  (icon: Icons.menu_book_outlined, label: '노트'),
  (icon: Icons.person_outline_rounded, label: '프로필'),
];

class NavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool horizontal;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.horizontal,
  });

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surfaceContainerLowest,
      borderRadius: widget.horizontal ? AppShape.option : AppShape.floating,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: widget.onTap,
        splashColor: context.colors.primaryContainer.withAlpha(100),
        borderRadius: widget.horizontal ? AppShape.option : AppShape.floating,
        child: Container(
          width: widget.horizontal ? double.infinity : 100,
          height: widget.horizontal ? 48 : 60,
          decoration: BoxDecoration(
            color: widget.isSelected
                ? context.colors.primaryContainer.withAlpha(150)
                : Colors.transparent,
            borderRadius: widget.horizontal
                ? AppShape.option
                : AppShape.floating,
          ),
          child: widget.horizontal
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      itemIcon(),
                      const SizedBox(
                        width: 8,
                      ),
                      itemLabel(),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    itemIcon(),
                    itemLabel(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget itemIcon() {
    return Icon(
      widget.icon,
      color: widget.isSelected
          ? context.colors.primary
          : context.colors.outline,
    );
  }

  Widget itemLabel() {
    final baseStyle = widget.horizontal
        ? TextType.titleSmall
        : TextType.captionLarge;
    return Text(
      widget.label,
      style: baseStyle.copyWith(
        color: widget.isSelected
            ? context.colors.primary
            : context.colors.outline,
        fontWeight: widget.isSelected ? FontWeight.w800 : FontWeight.w600,
      ),
    );
  }
}
