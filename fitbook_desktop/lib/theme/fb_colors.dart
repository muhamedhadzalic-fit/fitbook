import 'dart:math' as math;
import 'dart:ui';

/// FitBook palette — the single source of truth for colour in the admin app.
///
/// Mirrors the design system declared in the FitBook design canvas:
/// navy for primary surfaces and headers, bright blue for accents, white
/// background, light-gray cards.
abstract final class FBColors {
  static const navy = Color(0xFF1E3A5F);
  static const navyDeep = Color(0xFF15294A);
  static const navyTint = Color(0xFF2A4A75);

  static const blue = Color(0xFF2563EB);
  static const blueLight = Color(0xFFEFF4FF);

  static const bg = Color(0xFFFFFFFF);
  static const card = Color(0xFFF8FAFC);
  static const cardBorder = Color(0xFFE5E9F0);

  static const text = Color(0xFF0F172A);
  static const textMid = Color(0xFF475569);
  static const textDim = Color(0xFF94A3B8);

  static const green = Color(0xFF10B981);
  static const greenBg = Color(0xFFECFDF5);
  static const red = Color(0xFFEF4444);
  static const redBg = Color(0xFFFEF2F2);
  static const amber = Color(0xFFF59E0B);
  static const amberBg = Color(0xFFFFFBEB);

  /// Neutral used for "taken"/disabled slots.
  static const slotDisabled = Color(0xFFF1F5F9);

  /// Builds the two-stop gradient the design uses for avatars and photo
  /// placeholders, keyed by an OKLCH hue so identity colours stay perceptually
  /// even across the whole wheel.
  static List<Color> identityGradient(double hue) => [
    oklch(0.65, 0.14, hue),
    oklch(0.45, 0.16, hue + 30),
  ];

  /// Soft tinted background used by KPI tiles and report-type icons.
  static Color tintSoft(double hue) => oklch(0.95, 0.04, hue);

  /// Saturated foreground that pairs with [tintSoft].
  static Color tintStrong(double hue) => oklch(0.45, 0.15, hue);

  /// Converts an OKLCH triple to sRGB.
  ///
  /// The design system expresses its generated colours in OKLCH; CSS resolves
  /// that natively but Dart does not, so we do the Oklab -> linear sRGB ->
  /// sRGB conversion here to keep the rendered hues identical to the mockups.
  static Color oklch(double l, double c, double hueDeg) {
    final h = hueDeg * math.pi / 180.0;
    final a = c * math.cos(h);
    final b = c * math.sin(h);

    final lCube = _cube(l + 0.3963377774 * a + 0.2158037573 * b);
    final mCube = _cube(l - 0.1055613458 * a - 0.0638541728 * b);
    final sCube = _cube(l - 0.0894841775 * a - 1.2914855480 * b);

    final r =
        4.0767416621 * lCube - 3.3077115913 * mCube + 0.2309699292 * sCube;
    final g =
        -1.2684380046 * lCube + 2.6097574011 * mCube - 0.3413193965 * sCube;
    final bl =
        -0.0041960863 * lCube - 0.7034186147 * mCube + 1.7076147010 * sCube;

    return Color.fromARGB(255, _encode(r), _encode(g), _encode(bl));
  }

  static double _cube(double v) => v * v * v;

  static int _encode(double linear) {
    final v = linear <= 0.0031308
        ? 12.92 * linear
        : 1.055 * math.pow(linear, 1 / 2.4) - 0.055;
    return (v.clamp(0.0, 1.0) * 255).round();
  }
}
