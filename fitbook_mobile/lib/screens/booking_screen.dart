import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 7.4a · Create reservation — the confirmation step before a booking is sent.
///
/// The client never reports a successful payment; this screen only submits the
/// request, and the trainer confirms it afterwards.
class BookingScreen extends StatelessWidget {
  const BookingScreen({
    super.key,
    required this.trainer,
    this.onBack,
    this.onConfirmed,
  });

  final Trainer trainer;
  final VoidCallback? onBack;
  final VoidCallback? onConfirmed;

  Future<void> _confirm(BuildContext context) async {
    final draft = Mockup.bookingDraft;
    final confirmed = await showDialog<bool>(
      context: context,
      barrierColor: const Color(0x730F172A),
      builder: (context) => _ConfirmDialog(trainer: trainer, draft: draft),
    );
    if (confirmed == true) onConfirmed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final draft = Mockup.bookingDraft;

    return FBScreen(
      title: MockChrome.bookingTitle,
      titleStyle: FBText.titleMd,
      onBack: onBack,
      headerPadding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      actions: const [FBIconButton(icon: FBIcons.more)],
      bottomNav: _bottomBar(context),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        children: [
          _TrainerHeaderCard(trainer: trainer),
          const SizedBox(height: 16),
          _SessionDetails(draft: draft, trainer: trainer),
          const SizedBox(height: 14),
          _MembershipStrip(membership: draft.membership),
          const SizedBox(height: 14),
          Text(
            MockChrome.notesLabel,
            style: FBText.label.copyWith(color: FBColors.textMid),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 56),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: FBColors.card,
              borderRadius: FBRadius.all(FBRadius.button),
              border: Border.all(color: FBColors.cardBorder),
            ),
            child: Text(
              draft.notes,
              style: FBText.body.copyWith(color: FBColors.textMid),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: FBColors.cardBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: FBButton(
                  label: MockChrome.cancelLabel,
                  kind: FBButtonKind.outline,
                  onPressed: onBack,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: FBButton(
                  label: MockChrome.submitBookingLabel,
                  onPressed: () => _confirm(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrainerHeaderCard extends StatelessWidget {
  const _TrainerHeaderCard({required this.trainer});

  final Trainer trainer;

  @override
  Widget build(BuildContext context) {
    return FBNavyPanel(
      gradient: false,
      radius: 18,
      padding: const EdgeInsets.all(16),
      glow: FBPanelGlow.bottomRight,
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              FBAvatar(name: trainer.name, hue: trainer.identityHue, size: 56),
              if (trainer.isOnline)
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: FBColors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: FBColors.navy, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MockChrome.trainerEyebrow,
                  style: FBText.eyebrow.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  trainer.name,
                  style: FBText.h4.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  trainer.specialities.join(' · '),
                  style: FBText.label.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
          const Icon(FBIcons.chevronRight, size: 18, color: Colors.white),
        ],
      ),
    );
  }
}

class _SessionDetails extends StatelessWidget {
  const _SessionDetails({required this.draft, required this.trainer});

  final BookingDraft draft;
  final Trainer trainer;

  @override
  Widget build(BuildContext context) {
    return FBCard(
      radius: FBRadius.cardLg,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _DetailRow(
            icon: FBIcons.calendar,
            label: MockChrome.dateLabel,
            value: draft.dateLabel,
          ),
          _DetailRow(
            icon: FBIcons.clock,
            label: MockChrome.timeLabel,
            value: draft.timeLabel,
          ),
          _DetailRow(
            icon: FBIcons.pin,
            label: MockChrome.locationLabel,
            value: draft.location,
          ),
          _DetailRow(
            icon: FBIcons.user,
            label: MockChrome.spotsLabel,
            value: draft.spotsLabel,
          ),
          _DetailRow(
            icon: null,
            label: MockChrome.priceLabel,
            value: MockChrome.amountLabel(trainer.hourlyRate),
            emphasis: true,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.emphasis = false,
    this.isLast = false,
  });

  final IconData? icon;
  final String label;
  final String value;
  final bool emphasis;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: isLast
          ? null
          : const BoxDecoration(
              border: Border(bottom: BorderSide(color: FBColors.cardBorder)),
            ),
      child: Row(
        children: [
          if (icon != null)
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: FBColors.blueLight,
                borderRadius: FBRadius.all(FBRadius.control),
              ),
              child: Icon(icon, size: 15, color: FBColors.blue),
            )
          else
            const SizedBox(width: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: FBText.label.copyWith(color: FBColors.textMid),
            ),
          ),
          Text(
            value,
            style: emphasis
                ? FBText.titleMd.copyWith(color: FBColors.navy)
                : FBText.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: FBColors.text,
                  ),
          ),
        ],
      ),
    );
  }
}

class _MembershipStrip extends StatelessWidget {
  const _MembershipStrip({required this.membership});

  final MembershipSummary membership;

  @override
  Widget build(BuildContext context) {
    return FBNotice(
      background: FBColors.greenBg,
      borderColor: FBColors.green.withValues(alpha: 0.2),
      radius: FBRadius.card,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      crossAxisAlignment: CrossAxisAlignment.center,
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: FBColors.green,
              borderRadius: FBRadius.all(FBRadius.control),
            ),
            child: const Icon(FBIcons.check, size: 18, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(membership.tier, style: FBText.bodyStrong),
                const SizedBox(height: 1),
                Text(
                  membership.detail,
                  style: FBText.caption.copyWith(color: FBColors.textMid),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          FBBadge(
            label: membership.badge,
            background: FBColors.green,
            foreground: Colors.white,
            fontSize: 10,
          ),
        ],
      ),
    );
  }
}

/// Confirmation dialog — required before an irreversible booking submission.
class _ConfirmDialog extends StatelessWidget {
  const _ConfirmDialog({required this.trainer, required this.draft});

  final Trainer trainer;
  final BookingDraft draft;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: FBRadius.all(FBRadius.sheet)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: FBColors.blueLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  FBIcons.calendar,
                  size: 28,
                  color: FBColors.blue,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                MockChrome.confirmDialogTitle,
                textAlign: TextAlign.center,
                style: FBText.h4,
              ),
              const SizedBox(height: 6),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  style: FBText.body.copyWith(color: FBColors.textMid),
                  children: [
                    const TextSpan(text: MockChrome.confirmDialogLeadIn),
                    TextSpan(
                      text: trainer.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: FBColors.text,
                      ),
                    ),
                    const TextSpan(text: MockChrome.confirmDialogJoiner),
                    TextSpan(
                      text: '${draft.dateLabel} at ${draft.timeLabel}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: FBColors.text,
                      ),
                    ),
                    TextSpan(
                      text: MockChrome.confirmDialogWindow(draft.confirmWindow),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: FBButton(
                      label: MockChrome.confirmDialogDecline,
                      kind: FBButtonKind.outline,
                      height: 44,
                      radius: FBRadius.button,
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FBButton(
                      label: MockChrome.confirmDialogAccept,
                      kind: FBButtonKind.accent,
                      height: 44,
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
  }
}
