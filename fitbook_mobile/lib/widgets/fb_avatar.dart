import 'package:flutter/material.dart';

import '../theme/fb_theme.dart';

/// Gradient initials avatar.
///
/// The gradient is derived from an OKLCH [hue] so the same person always reads
/// as the same colour, whichever screen they appear on.
class FBAvatar extends StatelessWidget {
  const FBAvatar({
    super.key,
    required this.name,
    required this.hue,
    this.size = 48,
    this.ringColor,
  });

  final String name;
  final double hue;
  final double size;

  /// Draws a solid ring around the avatar, used where it overlaps a photo.
  final Color? ringColor;

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    return parts.take(2).map((p) => p.characters.first).join().toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: FBColors.identityGradient(hue),
        ),
      ),
      child: Text(
        _initials,
        style: TextStyle(
          fontFamily: 'Inter',
          color: Colors.white,
          fontSize: size * 0.36,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
      ),
    );

    if (ringColor == null) return avatar;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(color: ringColor, shape: BoxShape.circle),
      child: avatar,
    );
  }
}

/// A small numeric score pinned to the bottom-right of an avatar, used by the
/// recommendation cards.
class FBAvatarScore extends StatelessWidget {
  const FBAvatarScore({
    super.key,
    required this.score,
    required this.color,
    this.diameter = 22,
  });

  final int score;
  final Color color;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Container(
        width: diameter,
        height: diameter,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Text(
          '$score',
          style: TextStyle(
            fontFamily: 'Inter',
            color: Colors.white,
            fontSize: diameter * 0.41,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
