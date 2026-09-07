import 'package:flutter/material.dart';

import 'fb_colors.dart';

export 'fb_colors.dart';
export 'fb_icons.dart';

/// Corner radii used across the design: 12 for buttons/badges, 16 for cards.
abstract final class FBRadius {
  static const badge = 6.0;
  static const chip = 8.0;
  static const control = 10.0;
  static const button = 12.0;
  static const card = 14.0;
  static const cardLg = 16.0;
  static const sheet = 20.0;
  static const pill = 100.0;

  static BorderRadius all(double r) => BorderRadius.circular(r);
}

/// The layered shadow scale from the design tokens.
abstract final class FBShadow {
  static const sm = <BoxShadow>[
    BoxShadow(color: Color(0x0A0F172A), offset: Offset(0, 1), blurRadius: 2),
    BoxShadow(color: Color(0x0F0F172A), offset: Offset(0, 1), blurRadius: 3),
  ];

  static const md = <BoxShadow>[
    BoxShadow(color: Color(0x0F0F172A), offset: Offset(0, 4), blurRadius: 12),
    BoxShadow(color: Color(0x0A0F172A), offset: Offset(0, 2), blurRadius: 4),
  ];

  static const lg = <BoxShadow>[
    BoxShadow(color: Color(0x1A0F172A), offset: Offset(0, 12), blurRadius: 32),
    BoxShadow(color: Color(0x0A0F172A), offset: Offset(0, 4), blurRadius: 8),
  ];

  /// Coloured glow under a primary call-to-action.
  static List<BoxShadow> glow(Color color, {double opacity = 0.25}) => [
    BoxShadow(
      color: color.withValues(alpha: opacity),
      offset: const Offset(0, 4),
      blurRadius: 12,
    ),
  ];
}

/// Named text styles matching the design's type ramp.
///
/// Sizes, weights and letter-spacing are lifted directly from the mockups so
/// the Flutter build reads as the same document, not an approximation.
abstract final class FBText {
  static const _f = 'Inter';

  static const display = TextStyle(
    fontFamily: _f,
    fontSize: 36,
    fontWeight: FontWeight.w800,
    letterSpacing: -1,
    height: 1.05,
  );
  static const h1 = TextStyle(
    fontFamily: _f,
    fontSize: 26,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.6,
  );
  static const h2 = TextStyle(
    fontFamily: _f,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );
  static const h3 = TextStyle(
    fontFamily: _f,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
  );
  static const h4 = TextStyle(
    fontFamily: _f,
    fontSize: 17,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
  );
  static const titleMd = TextStyle(
    fontFamily: _f,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
  );
  static const titleSm = TextStyle(
    fontFamily: _f,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
  );
  static const bodyLg = TextStyle(
    fontFamily: _f,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const body = TextStyle(
    fontFamily: _f,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );
  static const bodyStrong = TextStyle(
    fontFamily: _f,
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );
  static const label = TextStyle(
    fontFamily: _f,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static const caption = TextStyle(
    fontFamily: _f,
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );
  static const micro = TextStyle(
    fontFamily: _f,
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  /// Uppercase eyebrow label ("YOUR TRAINER", "MATCH SCORE").
  static const eyebrow = TextStyle(
    fontFamily: _f,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );

  /// Monospace, used for booking references and weight percentages.
  static const mono = TextStyle(
    fontFamilyFallback: ['Menlo', 'SF Mono', 'monospace'],
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );
}

/// The app-wide [ThemeData] for the Windows admin app.
abstract final class FBTheme {
  static ThemeData build() {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: FBColors.bg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: FBColors.navy,
        primary: FBColors.navy,
        secondary: FBColors.blue,
        surface: FBColors.bg,
        error: FBColors.red,
      ),
      textTheme: base.textTheme.apply(
        fontFamily: 'Inter',
        bodyColor: FBColors.text,
        displayColor: FBColors.text,
      ),
      splashFactory: InkSparkle.splashFactory,
      dividerTheme: const DividerThemeData(
        color: FBColors.cardBorder,
        thickness: 1,
        space: 1,
      ),
      // The design shows no Material app bars — every screen builds its own
      // header row — so the default is stripped rather than restyled.
      appBarTheme: const AppBarTheme(
        backgroundColor: FBColors.bg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
    );
  }
}
