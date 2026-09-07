import 'package:flutter/material.dart';

import '../theme/fb_theme.dart';
import 'fb_button.dart';

/// A screen scaffold with the design's standard header row: a square back
/// button, a title (with optional subtitle), and trailing actions.
class FBScreen extends StatelessWidget {
  const FBScreen({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.onBack,
    this.actions = const [],
    this.bottomNav,
    this.headerBorder = false,
    this.headerPadding = const EdgeInsets.fromLTRB(20, 12, 20, 14),
    this.background,
    this.titleStyle,
  });

  final Widget child;
  final String? title;
  final String? subtitle;
  final VoidCallback? onBack;
  final List<Widget> actions;
  final Widget? bottomNav;

  /// Draws a hairline under the header, as on the reservation-history screen.
  final bool headerBorder;

  final EdgeInsetsGeometry headerPadding;
  final Color? background;
  final TextStyle? titleStyle;

  bool get _hasHeader =>
      title != null || onBack != null || actions.isNotEmpty || subtitle != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background ?? FBColors.bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            if (_hasHeader)
              Container(
                padding: headerPadding,
                decoration: headerBorder
                    ? const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: FBColors.cardBorder),
                        ),
                      )
                    : null,
                child: Row(
                  children: [
                    if (onBack != null) ...[
                      FBIconButton(icon: FBIcons.back, onPressed: onBack),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (title != null)
                            Text(title!, style: titleStyle ?? FBText.h4),
                          if (subtitle != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: Text(
                                subtitle!,
                                style: FBText.caption.copyWith(
                                  color: FBColors.textDim,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    for (final a in actions) ...[const SizedBox(width: 8), a],
                  ],
                ),
              ),
            Expanded(child: child),
            ?bottomNav,
          ],
        ),
      ),
    );
  }
}
