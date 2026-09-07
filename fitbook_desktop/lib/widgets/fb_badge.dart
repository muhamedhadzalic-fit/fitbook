import 'package:flutter/material.dart';

import '../models/enums.dart';
import '../theme/fb_theme.dart';

/// A pill badge with an optional leading status dot.
class FBBadge extends StatelessWidget {
  const FBBadge({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
    this.showDot = false,
    this.fontSize = 11,
    this.uppercase = false,
    this.dotColor,
  });

  final String label;
  final Color background;
  final Color foreground;
  final bool showDot;
  final double fontSize;
  final bool uppercase;

  /// Overrides the status dot's colour when it should differ from the text,
  /// e.g. a muted dot beside mid-grey label text.
  final Color? dotColor;

  /// Badge styled for a booking status, using the tint the design assigns it.
  factory FBBadge.forStatus(BookingStatus status, {bool uppercase = false}) {
    final (bg, fg, label) = statusTint(status);
    return FBBadge(
      label: label,
      background: bg,
      foreground: fg,
      showDot: true,
      uppercase: uppercase,
      fontSize: uppercase ? 10 : 11,
    );
  }

  /// The (background, foreground, label) triple for a booking status.
  static (Color, Color, String) statusTint(
    BookingStatus status,
  ) => switch (status) {
    BookingStatus.pending => (FBColors.amberBg, FBColors.amber, 'Pending'),
    BookingStatus.confirmed => (FBColors.greenBg, FBColors.green, 'Confirmed'),
    BookingStatus.completed => (FBColors.blueLight, FBColors.blue, 'Completed'),
    BookingStatus.cancelled => (FBColors.card, FBColors.textMid, 'Cancelled'),
    BookingStatus.rejected => (FBColors.redBg, FBColors.red, 'Rejected'),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: showDot ? 10 : 9, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: FBRadius.all(FBRadius.badge),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: dotColor ?? foreground,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
          ],
          // Flexible so a long status never overflows a narrow table column.
          Flexible(
            child: Text(
              uppercase ? label.toUpperCase() : label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: foreground,
                letterSpacing: uppercase ? 0.3 : 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The small blue-on-blue speciality tag used on trainer cards.
class FBTag extends StatelessWidget {
  const FBTag({
    super.key,
    required this.label,
    this.fontSize = 10,
    this.background,
    this.foreground,
    this.border,
  });

  final String label;
  final double fontSize;
  final Color? background;
  final Color? foreground;
  final Color? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: fontSize <= 10 ? 7 : 10,
        vertical: fontSize <= 10 ? 2 : 5,
      ),
      decoration: BoxDecoration(
        color: background ?? FBColors.blueLight,
        borderRadius: FBRadius.all(fontSize <= 10 ? 6 : FBRadius.chip),
        border: border == null ? null : Border.all(color: border!),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: foreground ?? FBColors.blue,
        ),
      ),
    );
  }
}

/// A counted numeric bubble, used on notification bells.
class FBCountBubble extends StatelessWidget {
  const FBCountBubble({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 18),
      height: 18,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: FBColors.blue,
        borderRadius: FBRadius.all(9),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
