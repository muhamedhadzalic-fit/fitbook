import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 7.4b · Reservation history — where a freshly submitted booking lands.
class ReservationHistoryScreen extends StatefulWidget {
  const ReservationHistoryScreen({
    super.key,
    this.onBack,
    this.highlightNewest = false,
  });

  final VoidCallback? onBack;

  /// Shows the "submitted" banner and outlines the newest booking, used when
  /// arriving straight from the booking flow.
  final bool highlightNewest;

  @override
  State<ReservationHistoryScreen> createState() =>
      _ReservationHistoryScreenState();
}

class _ReservationHistoryScreenState extends State<ReservationHistoryScreen> {
  final _history = Mockup.reservationHistory;
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tab = _history.tabs[_tabIndex];
    final rows = _history.byTab[tab.id] ?? const [];

    return FBScreen(
      title: MockChrome.reservationsTitle,
      subtitle: _history.totalLabel,
      onBack: widget.onBack,
      headerBorder: true,
      headerPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      actions: const [FBIconButton(icon: FBIcons.filter, iconSize: 16)],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: FBSegmentedTabs(
              labels: [for (final t in _history.tabs) t.label],
              counts: [for (final t in _history.tabs) t.count],
              selectedIndex: _tabIndex,
              onChanged: (i) => setState(() => _tabIndex = i),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
              children: [
                if (widget.highlightNewest && _tabIndex == 0) ...[
                  _SubmittedBanner(toast: _history.submittedToast),
                  const SizedBox(height: 12),
                ],
                for (final r in rows)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ReservationCard(
                      reservation: r,
                      // Only flag the new booking when we actually came from
                      // the booking flow.
                      isNew: widget.highlightNewest && r.isJustCreated,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SubmittedBanner extends StatelessWidget {
  const _SubmittedBanner({required this.toast});

  final SubmittedToast toast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: FBColors.green,
        borderRadius: FBRadius.all(FBRadius.button),
        boxShadow: FBShadow.glow(FBColors.green, opacity: 0.25),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              shape: BoxShape.circle,
            ),
            child: const Icon(FBIcons.check, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  toast.title,
                  style: FBText.bodyStrong.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 1),
                Text(
                  toast.body,
                  style: FBText.caption.copyWith(
                    color: Colors.white.withValues(alpha: 0.95),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A reservation row. The action set is driven by [Reservation.status] so the
/// card always offers exactly the transitions the state machine allows.
class ReservationCard extends StatelessWidget {
  const ReservationCard({
    super.key,
    required this.reservation,
    this.isNew = false,
  });

  final Reservation reservation;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        FBCard(
          radius: FBRadius.card,
          borderColor: isNew ? FBColors.amber : null,
          borderWidth: isNew ? 2 : 1,
          shadow: isNew
              ? FBShadow.glow(FBColors.amber, opacity: 0.18)
              : FBShadow.sm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleRow(),
              const SizedBox(height: 12),
              _MetaRow(
                icon: FBIcons.calendar,
                text: MockChrome.dateAndTime(
                  reservation.dateLabel,
                  reservation.timeLabel,
                ),
              ),
              const SizedBox(height: 6),
              _MetaRow(icon: FBIcons.pin, text: reservation.location),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    reservation.reference,
                    style: FBText.mono.copyWith(color: FBColors.textDim),
                  ),
                  const Spacer(),
                  Text(
                    MockChrome.amountLabel(reservation.amount),
                    style: FBText.titleSm.copyWith(color: FBColors.navy),
                  ),
                ],
              ),
              if (reservation.membershipNote != null &&
                  reservation.status == BookingStatus.pending) ...[
                const SizedBox(height: 10),
                FBNotice(
                  background: FBColors.greenBg,
                  icon: FBIcons.check,
                  iconColor: FBColors.green,
                  radius: FBRadius.chip,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  crossAxisAlignment: CrossAxisAlignment.center,
                  child: Text(
                    MockChrome.coveredByLabel(reservation.membershipNote!),
                    style: FBText.micro.copyWith(color: FBColors.green),
                  ),
                ),
              ],
              if (reservation.cancellationReason != null) ...[
                const SizedBox(height: 10),
                Text(
                  reservation.cancellationReason!,
                  style: FBText.caption.copyWith(
                    color: FBColors.textMid,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
              ..._actions(),
            ],
          ),
        ),
        if (isNew)
          Positioned(
            top: -10,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: FBColors.amber,
                borderRadius: FBRadius.all(FBRadius.pill),
                boxShadow: FBShadow.glow(FBColors.amber, opacity: 0.3),
              ),
              child: Text(
                MockChrome.justCreatedTag,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Pairs the label list from the mock layer with the visual weights this
  /// card assigns them, so labels stay data and styling stays code.
  static List<({String label, FBButtonKind kind})> _zip(
    List<String> labels,
    List<FBButtonKind> kinds,
  ) => [
    for (var i = 0; i < labels.length; i++) (label: labels[i], kind: kinds[i]),
  ];

  Widget _titleRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FBAvatar(
          name: reservation.trainerName,
          hue: reservation.trainerHue,
          size: 42,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(reservation.trainerName, style: FBText.titleSm),
              const SizedBox(height: 3),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [
                  for (final s in reservation.specialities)
                    FBTag(label: s, fontSize: 9),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        FBBadge.forStatus(reservation.status, uppercase: true),
      ],
    );
  }

  /// Actions offered per status — no card ever exposes a transition the
  /// booking state machine would reject.
  List<Widget> _actions() {
    final buttons = switch (reservation.status) {
      // The destructive action leads, then a neutral one, then the primary.
      BookingStatus.pending => _zip(MockChrome.pendingActions, const [
        FBButtonKind.danger,
        FBButtonKind.outline,
        FBButtonKind.primary,
      ]),
      BookingStatus.confirmed => _zip(MockChrome.confirmedActions, const [
        FBButtonKind.outline,
        FBButtonKind.primary,
      ]),
      BookingStatus.completed => _zip(MockChrome.completedActions, const [
        FBButtonKind.outline,
        FBButtonKind.quiet,
      ]),
      BookingStatus.cancelled || BookingStatus.rejected => const [],
    };

    if (buttons.isEmpty) return const [];

    return [
      const SizedBox(height: 12),
      Row(
        children: [
          for (var i = 0; i < buttons.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            Expanded(
              child: FBButton(
                label: buttons[i].label,
                kind: buttons[i].kind,
                height: 38,
                fontSize: 12,
                radius: FBRadius.control,
              ),
            ),
          ],
        ],
      ),
    ];
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: FBColors.textMid),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: FBText.label.copyWith(
              fontWeight: FontWeight.w500,
              color: FBColors.text,
            ),
          ),
        ),
      ],
    );
  }
}
