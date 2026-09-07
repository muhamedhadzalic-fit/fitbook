import 'package:flutter/material.dart';

import '../theme/fb_theme.dart';

/// Visual weights a [FBButton] can take, mirroring the design's button set.
enum FBButtonKind {
  /// Navy fill with a soft navy glow — the primary action.
  primary,

  /// Bright blue fill — used where the primary action is confirmatory.
  accent,

  /// Green fill — accepting a booking.
  positive,

  /// White fill, grey border — secondary actions.
  outline,

  /// White fill, red text — destructive but not yet confirmed.
  danger,

  /// Solid red fill — the confirmed destructive action inside a dialog.
  destructive,

  /// Transparent, tinted text — tertiary.
  quiet,
}

/// The standard FitBook button.
class FBButton extends StatelessWidget {
  const FBButton({
    super.key,
    required this.label,
    this.onPressed,
    this.kind = FBButtonKind.primary,
    this.icon,
    this.trailingLabel,
    this.trailingIcon,
    this.height = 48,
    this.fontSize = 14,
    this.radius = FBRadius.card,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final FBButtonKind kind;
  final IconData? icon;

  /// Secondary text pinned to the right edge, e.g. "45 KM · Fri 10:00".
  final String? trailingLabel;

  final IconData? trailingIcon;
  final double height;
  final double fontSize;
  final double radius;
  final bool expand;

  ({Color bg, Color fg, Color? border, List<BoxShadow>? shadow}) get _style =>
      switch (kind) {
        FBButtonKind.primary => (
          bg: FBColors.navy,
          fg: Colors.white,
          border: null,
          shadow: FBShadow.glow(FBColors.navy),
        ),
        FBButtonKind.accent => (
          bg: FBColors.blue,
          fg: Colors.white,
          border: null,
          shadow: FBShadow.glow(FBColors.blue, opacity: 0.3),
        ),
        FBButtonKind.positive => (
          bg: FBColors.green,
          fg: Colors.white,
          border: null,
          shadow: FBShadow.glow(FBColors.green),
        ),
        FBButtonKind.outline => (
          bg: Colors.white,
          fg: FBColors.text,
          border: FBColors.cardBorder,
          shadow: null,
        ),
        FBButtonKind.danger => (
          bg: Colors.white,
          fg: FBColors.red,
          border: FBColors.cardBorder,
          shadow: null,
        ),
        FBButtonKind.destructive => (
          bg: FBColors.red,
          fg: Colors.white,
          border: null,
          shadow: FBShadow.glow(FBColors.red),
        ),
        FBButtonKind.quiet => (
          bg: FBColors.blueLight,
          fg: FBColors.blue,
          border: null,
          shadow: null,
        ),
      };

  @override
  Widget build(BuildContext context) {
    final s = _style;
    final content = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: trailingLabel == null
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: fontSize + 2, color: s.fg),
                const SizedBox(width: 7),
              ],
              // Labels stay on one line and ellipsize rather than overflowing
              // when the button is squeezed into a narrow column.
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    color: s.fg,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: 7),
                Icon(trailingIcon, size: fontSize + 2, color: s.fg),
              ],
            ],
          ),
        ),
        if (trailingLabel != null)
          Text(
            trailingLabel!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: fontSize - 2,
              fontWeight: FontWeight.w600,
              color: s.fg.withValues(alpha: 0.85),
            ),
          ),
      ],
    );

    return Material(
      color: s.bg,
      borderRadius: FBRadius.all(radius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: FBRadius.all(radius),
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            borderRadius: FBRadius.all(radius),
            border: s.border == null
                ? null
                : Border.all(color: s.border!, width: 1.5),
            boxShadow: s.shadow,
          ),
          child: content,
        ),
      ),
    );
  }
}

/// A square icon button on a card-tinted surface — the design's standard
/// back / bell / filter affordance.
class FBIconButton extends StatelessWidget {
  const FBIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 40,
    this.iconSize = 18,
    this.background,
    this.iconColor,
    this.borderColor,
    this.badge,
    this.dotColor,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;
  final Color? background;
  final Color? iconColor;
  final Color? borderColor;

  /// Numeric bubble in the top-right corner.
  final Widget? badge;

  /// Small solid dot instead of a count, for "has unread" states.
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: background ?? FBColors.card,
      borderRadius: FBRadius.all(FBRadius.button),
      child: InkWell(
        onTap: onPressed,
        borderRadius: FBRadius.all(FBRadius.button),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: FBRadius.all(FBRadius.button),
            border: Border.all(color: borderColor ?? FBColors.cardBorder),
          ),
          child: Icon(icon, size: iconSize, color: iconColor ?? FBColors.navy),
        ),
      ),
    );

    if (badge == null && dotColor == null) return button;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        button,
        if (badge != null) Positioned(top: -4, right: -4, child: badge!),
        if (dotColor != null)
          Positioned(
            top: 7,
            right: 7,
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
            ),
          ),
      ],
    );
  }
}

/// A compact bordered text button, used in table header strips and toolbars.
class FBTextButton extends StatelessWidget {
  const FBTextButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.isPrimary = false,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;

  /// Navy fill instead of a white outline.
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final fg = isPrimary ? Colors.white : FBColors.textMid;

    return Material(
      color: isPrimary ? FBColors.navy : Colors.white,
      borderRadius: FBRadius.all(FBRadius.chip),
      child: InkWell(
        onTap: onPressed,
        borderRadius: FBRadius.all(FBRadius.chip),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: FBRadius.all(FBRadius.chip),
            border: isPrimary ? null : Border.all(color: FBColors.cardBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 13, color: fg),
                const SizedBox(width: 6),
              ],
              Text(label, style: FBText.label.copyWith(color: fg)),
            ],
          ),
        ),
      ),
    );
  }
}
