import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// Stands in for a sidebar section that exists in the design but has no screen
/// yet, so a click is never a dead end.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.sectionLabel});

  final String sectionLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: FBCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: FBColors.card,
                  borderRadius: FBRadius.all(FBRadius.button),
                ),
                child: const Icon(
                  FBIcons.settings,
                  size: 22,
                  color: FBColors.textMid,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                '$sectionLabel — ${MockNav.placeholderTitle}',
                textAlign: TextAlign.center,
                style: FBText.titleSm,
              ),
              const SizedBox(height: 6),
              Text(
                MockNav.placeholderBody,
                textAlign: TextAlign.center,
                style: FBText.body.copyWith(
                  color: FBColors.textMid,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
