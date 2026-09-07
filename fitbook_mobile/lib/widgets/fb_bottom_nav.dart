import 'package:flutter/material.dart';

import '../models/home_feed.dart';
import '../theme/fb_theme.dart';

/// The client-facing bottom navigation bar.
class FBBottomNav extends StatelessWidget {
  const FBBottomNav({
    super.key,
    required this.destinations,
    required this.activeId,
    this.onChanged,
  });

  final List<NavDestination> destinations;
  final String activeId;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: FBColors.cardBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final d in destinations)
                _NavItem(
                  destination: d,
                  isActive: d.id == activeId,
                  onTap: onChanged == null ? null : () => onChanged!(d.id),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.destination,
    required this.isActive,
    this.onTap,
  });

  final NavDestination destination;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? FBColors.blue : FBColors.textDim;
    return InkWell(
      onTap: onTap,
      borderRadius: FBRadius.all(FBRadius.button),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FBIcons.byKey(destination.iconKey), size: 22, color: color),
            const SizedBox(height: 2),
            Text(
              destination.label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
