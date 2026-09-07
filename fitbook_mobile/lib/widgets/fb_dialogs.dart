import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import 'fb_button.dart';

/// Confirmation dialog for an action the user cannot silently undo.
///
/// Returns `true` only when the user picks the confirming action; dismissing by
/// tapping the barrier resolves to `false`.
Future<bool> showFBConfirm(
  BuildContext context, {
  required String title,
  required String body,
  required String cancelLabel,
  required String confirmLabel,
  bool isDestructive = false,
}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierColor: const Color(0x730F172A),
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      shape: RoundedRectangleBorder(
        borderRadius: FBRadius.all(FBRadius.cardLg),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: FBText.titleMd),
            const SizedBox(height: 8),
            Text(
              body,
              style: FBText.body.copyWith(color: FBColors.textMid, height: 1.5),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FBButton(
                    label: cancelLabel,
                    kind: FBButtonKind.outline,
                    height: 44,
                    fontSize: 13,
                    radius: FBRadius.button,
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FBButton(
                    label: confirmLabel,
                    kind: isDestructive
                        ? FBButtonKind.destructive
                        : FBButtonKind.primary,
                    height: 44,
                    fontSize: 13,
                    radius: FBRadius.button,
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  return result ?? false;
}

/// Sheet shown when a navigation target is in the design but has no screen.
///
/// Every row in the app stays tappable — a tap that does nothing at all reads
/// as a broken build. The desktop shell solves the same problem with
/// `placeholder_screen.dart`.
Future<void> showFBNotBuilt(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.white,
    barrierColor: const Color(0x730F172A),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: FBColors.cardBorder,
                  borderRadius: FBRadius.all(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: FBColors.card,
                borderRadius: FBRadius.all(FBRadius.button),
              ),
              child: const Icon(
                FBIcons.alert,
                size: 20,
                color: FBColors.textMid,
              ),
            ),
            const SizedBox(height: 14),
            Text(MockSession.notBuiltTitle, style: FBText.titleMd),
            const SizedBox(height: 6),
            Text(
              MockSession.notBuiltBody,
              style: FBText.body.copyWith(color: FBColors.textMid, height: 1.5),
            ),
            const SizedBox(height: 20),
            FBButton(
              label: MockSession.notBuiltDismiss,
              kind: FBButtonKind.outline,
              height: 46,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    ),
  );
}
