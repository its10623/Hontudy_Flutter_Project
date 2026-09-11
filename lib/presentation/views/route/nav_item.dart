import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';

import '../../core/theme/context_theme_extension.dart';

class NavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
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
