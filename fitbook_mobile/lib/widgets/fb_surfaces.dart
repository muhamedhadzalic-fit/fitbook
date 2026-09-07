import 'package:flutter/material.dart';

import '../theme/fb_theme.dart';

/// The default white card: 1px border, 14–16px radius, small layered shadow.
class FBCard extends StatelessWidget {
  const FBCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.radius = FBRadius.card,
    this.background,
    this.borderColor,
    this.borderWidth = 1,
    this.shadow = FBShadow.sm,
    this.onTap,
    this.clip = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color? background;
  final Color? borderColor;
  final double borderWidth;
  final List<BoxShadow>? shadow;
  final VoidCallback? onTap;

  /// Clips children to the card's radius — needed when a child paints to the
  /// edge (tables, hero images).
  final bool clip;

  @override
  Widget build(BuildContext context) {
    final decorated = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background ?? Colors.white,
        borderRadius: FBRadius.all(radius),
        border: Border.all(
          color: borderColor ?? FBColors.cardBorder,
          width: borderWidth,
        ),
        boxShadow: shadow,
      ),
      clipBehavior: clip ? Clip.antiAlias : Clip.none,
      child: child,
    );

    if (onTap == null) return decorated;
    return InkWell(
      onTap: onTap,
      borderRadius: FBRadius.all(radius),
      child: decorated,
    );
  }
}

/// The navy gradient panel used for hero banners and the membership card.
class FBNavyPanel extends StatelessWidget {
  const FBNavyPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    this.radius = FBRadius.cardLg,
    this.gradient = true,
    this.glow = FBPanelGlow.topRight,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;

  /// Navy-to-deep-navy gradient; when false the panel is flat navy.
  final bool gradient;

  /// The soft blue circle the design bleeds off one corner.
  final FBPanelGlow? glow;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: FBRadius.all(radius),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: gradient ? null : FBColors.navy,
          gradient: gradient
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [FBColors.navy, FBColors.navyDeep],
                )
              : null,
        ),
        child: Stack(
          children: [
            if (glow != null)
              Positioned(
                top: glow!.top,
                right: glow!.right,
                bottom: glow!.bottom,
                left: glow!.left,
                child: Container(
                  width: glow!.size,
                  height: glow!.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: FBColors.blue.withValues(alpha: glow!.opacity),
                  ),
                ),
              ),
            Padding(padding: padding, child: child),
          ],
        ),
      ),
    );
  }
}

/// Placement and size of the decorative blue circle inside an [FBNavyPanel].
class FBPanelGlow {
  const FBPanelGlow({
    this.top,
    this.right,
    this.bottom,
    this.left,
    required this.size,
    required this.opacity,
  });

  final double? top;
  final double? right;
  final double? bottom;
  final double? left;
  final double size;
  final double opacity;

  /// Default — small circle off the top-right corner.
  static const topRight = FBPanelGlow(
    top: -20,
    right: -20,
    size: 110,
    opacity: 0.25,
  );

  /// Bottom-right variant, as used on the booking screen's trainer card.
  static const bottomRight = FBPanelGlow(
    bottom: -30,
    right: -30,
    size: 130,
    opacity: 0.18,
  );

  /// Large, brighter circle used behind hero figures.
  static const hero = FBPanelGlow(
    top: -40,
    right: -40,
    size: 160,
    opacity: 0.3,
  );
}

/// Uppercase small-caps section label.
class FBSectionLabel extends StatelessWidget {
  const FBSectionLabel(
    this.text, {
    super.key,
    this.color = FBColors.textDim,
    this.padding = const EdgeInsets.only(left: 4, top: 12, bottom: 8),
    this.fontSize = 10,
  });

  final String text;
  final Color color;
  final EdgeInsetsGeometry padding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

/// A thin progress/weight bar.
class FBMeter extends StatelessWidget {
  const FBMeter({
    super.key,
    required this.fraction,
    required this.color,
    this.track,
    this.height = 6,
  });

  /// 0..1 fill ratio.
  final double fraction;

  final Color color;
  final Color? track;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: FBRadius.all(height / 2),
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            Container(color: track ?? FBColors.card),
            FractionallySizedBox(
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

/// An inline tinted notice — the amber "verification needed" and green
/// "covered by membership" strips.
class FBNotice extends StatelessWidget {
  const FBNotice({
    super.key,
    required this.child,
    required this.background,
    this.icon,
    this.iconColor,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    this.radius = FBRadius.control,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final Widget child;
  final Color background;
  final IconData? icon;
  final Color? iconColor;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;
  final double radius;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: FBRadius.all(radius),
        border: borderColor == null ? null : Border.all(color: borderColor!),
      ),
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(width: 10),
          ],
          Expanded(child: child),
        ],
      ),
    );
  }
}
