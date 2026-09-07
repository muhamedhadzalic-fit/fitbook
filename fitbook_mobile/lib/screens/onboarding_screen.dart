import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 7.1a · Welcome — the app's first screen.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key, this.onCreateAccount, this.onSignIn});

  final VoidCallback? onCreateAccount;
  final VoidCallback? onSignIn;

  @override
  Widget build(BuildContext context) {
    final slide = Mockup.welcome;

    return Scaffold(
      backgroundColor: FBColors.navy,
      body: Stack(
        children: [
          // Two soft blue orbs bleeding off opposite edges.
          Positioned(top: -60, right: -60, child: _orb(240, 0.25)),
          Positioned(bottom: 200, left: -80, child: _orb(200, 0.15)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 40, 28, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: FBColors.blue,
                      borderRadius: FBRadius.all(FBRadius.cardLg),
                      boxShadow: [
                        BoxShadow(
                          color: FBColors.blue.withValues(alpha: 0.4),
                          offset: const Offset(0, 8),
                          blurRadius: 24,
                        ),
                      ],
                    ),
                    child: const Text(
                      'F',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    slide.headline,
                    style: FBText.display.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    slide.body,
                    style: FBText.bodyLg.copyWith(
                      color: Colors.white.withValues(alpha: 0.75),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      for (var i = 0; i < slide.slideCount; i++) ...[
                        if (i > 0) const SizedBox(width: 6),
                        Container(
                          width: i == slide.activeIndex ? 24 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: i == slide.activeIndex
                                ? FBColors.blue
                                : Colors.white.withValues(alpha: 0.3),
                            borderRadius: FBRadius.all(3),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 40),
                  FBButton(
                    label: slide.primaryCta,
                    kind: FBButtonKind.accent,
                    height: 52,
                    fontSize: 15,
                    onPressed: onCreateAccount,
                  ),
                  const SizedBox(height: 10),
                  _GhostButton(label: slide.secondaryCta, onTap: onSignIn),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      slide.legalNote,
                      textAlign: TextAlign.center,
                      style: FBText.caption.copyWith(
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _orb(double size, double opacity) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: FBColors.blue.withValues(alpha: opacity),
    ),
  );
}

/// A translucent button on the navy welcome surface.
class _GhostButton extends StatelessWidget {
  const _GhostButton({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.1),
      borderRadius: FBRadius.all(FBRadius.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: FBRadius.all(FBRadius.card),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: FBRadius.all(FBRadius.card),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: Text(
            label,
            style: FBText.bodyLg.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
