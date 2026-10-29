import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/app_layout.dart';

import '../../core/theme/context_theme_extension.dart';

import '../component/chat/mascot_avatar.dart';
import 'nav_item.dart';

const double _mascotSize = 30;

class SideNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const SideNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
      ),
      child: SizedBox(
        width: AppLayout.railWidth,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: Row(
                      children: [
                        const MascotAvatar(
                          size: _mascotSize,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '혼터디',
                          style: context.textStyles.titleLarge?.copyWith(
                            color: context.colors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  for (final (index, item) in navDestinations.indexed) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: NavItem(
                        icon: item.icon,
                        label: item.label,
                        isSelected: currentIndex == index,
                        onTap: () => onTap(index),
                        horizontal: true,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ],
              ),
            ),
            VerticalDivider(
              width: 1.0,
              thickness: 1.0,
              color: context.colors.outlineVariant.withAlpha(100),
            ),
          ],
        ),
      ),
    );
  }
}
