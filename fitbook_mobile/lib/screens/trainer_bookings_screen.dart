import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 7.8 · Trainer bookings management.
///
/// Trainers — not admins — confirm and reject their own bookings, which is what
/// the accept/decline pair on each pending card does.
class TrainerBookingsScreen extends StatefulWidget {
  const TrainerBookingsScreen({super.key});

  @override
  State<TrainerBookingsScreen> createState() => _TrainerBookingsScreenState();
}

class _TrainerBookingsScreenState extends State<TrainerBookingsScreen> {
  final _workspace = Mockup.trainerWorkspace;
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = _workspace.tabs;

    return Scaffold(
      backgroundColor: FBColors.bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: FBColors.cardBorder)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      FBAvatar(
                        name: _workspace.trainerName,
                        hue: _workspace.trainerHue,
                        size: 40,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _workspace.roleLabel,
                              style: FBText.caption.copyWith(
                                fontWeight: FontWeight.w600,
                                color: FBColors.textDim,
                              ),
                            ),
                            Text(
                              MockChrome.trainerBookingsTitle,
                              style: FBText.titleMd,
                            ),
                          ],
                        ),
                      ),
                      const FBIconButton(
                        icon: FBIcons.bell,
                        size: 36,
                        iconSize: 16,
                        dotColor: FBColors.red,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  FBSegmentedTabs(
                    labels: [for (final t in tabs) t.label],
                    counts: [for (final t in tabs) t.count],
                    selectedIndex: _tabIndex,
                    onChanged: (i) => setState(() => _tabIndex = i),
                  ),
                ],
              ),
            ),
            Expanded(child: _body(tabs[_tabIndex].id)),
          ],
        ),
      ),
    );
  }

  Widget _body(String tabId) {
    return switch (tabId) {
      'pending' => ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        children: [
          FBNotice(
            background: FBColors.amberBg,
            icon: FBIcons.alert,
            iconColor: FBColors.amber,
            child: Text(
              _workspace.pendingNotice,
              style: FBText.caption.copyWith(color: FBColors.text, height: 1.5),
            ),
          ),
          const SizedBox(height: 12),
          for (final request in _workspace.requests)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _RequestCard(request: request),
            ),
        ],
      ),
      'upcoming' => ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        children: [
          for (final session in _workspace.confirmed)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _ConfirmedCard(session: session),
            ),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: FBColors.card,
              borderRadius: FBRadius.all(FBRadius.button),
              border: Border.all(color: FBColors.cardBorder),
            ),
            child: Text(
              _workspace.confirmedFooter,
              style: FBText.label.copyWith(
                fontWeight: FontWeight.w500,
                color: FBColors.textMid,
              ),
            ),
          ),
        ],
      ),
      _ => Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Text(
            _workspace.historyPlaceholder,
            textAlign: TextAlign.center,
            style: FBText.body.copyWith(color: FBColors.textMid),
          ),
        ),
      ),
    };
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.request});

  final BookingRequest request;

  @override
  Widget build(BuildContext context) {
    return FBCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FBAvatar(
                name: request.clientName,
                hue: request.clientHue,
                size: 42,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(request.clientName, style: FBText.titleSm),
                    const SizedBox(height: 1),
                    Text(
                      request.reference,
                      style: FBText.mono.copyWith(
                        fontSize: 11,
                        color: FBColors.textDim,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const FBBadge(
                label: MockChrome.pendingTag,
                background: FBColors.amberBg,
                foreground: FBColors.amber,
                fontSize: 10,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _MetaRow(
            icon: FBIcons.calendar,
            text: MockChrome.dateAndTime(request.dateLabel, request.timeLabel),
          ),
          const SizedBox(height: 6),
          _MetaRow(icon: FBIcons.pin, text: request.location),
          const SizedBox(height: 6),
          _MetaRow(
            icon: FBIcons.money,
            text: MockChrome.durationSummary(
              request.amount,
              request.durationLabel,
            ),
          ),
          if (request.hasNote) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: FBColors.card,
                borderRadius: FBRadius.all(FBRadius.control),
              ),
              child: Text(
                MockChrome.quoted(request.clientNote),
                style: FBText.caption.copyWith(
                  color: FBColors.textMid,
                  fontStyle: FontStyle.italic,
                  height: 1.45,
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FBButton(
                  label: MockTrainerWorkspace.declineLabel,
                  kind: FBButtonKind.danger,
                  height: 40,
                  fontSize: 13,
                  radius: FBRadius.control,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: FBButton(
                  label: MockTrainerWorkspace.acceptLabel,
                  kind: FBButtonKind.positive,
                  height: 40,
                  fontSize: 13,
                  radius: FBRadius.control,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConfirmedCard extends StatelessWidget {
  const _ConfirmedCard({required this.session});

  final ConfirmedSession session;

  @override
  Widget build(BuildContext context) {
    return FBCard(
      child: Column(
        children: [
          Row(
            children: [
              FBAvatar(
                name: session.clientName,
                hue: session.clientHue,
                size: 42,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(session.clientName, style: FBText.titleSm),
                    const SizedBox(height: 1),
                    Text(
                      MockChrome.dateAndTime(
                        session.dateLabel,
                        session.timeLabel,
                      ),
                      style: FBText.caption.copyWith(color: FBColors.textDim),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              FBBadge.forStatus(BookingStatus.confirmed, uppercase: true),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(FBIcons.pin, size: 11, color: FBColors.textMid),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  session.location,
                  style: FBText.caption.copyWith(color: FBColors.textMid),
                ),
              ),
              Text(
                MockChrome.amountLabel(session.amount),
                style: FBText.bodyStrong.copyWith(color: FBColors.navy),
              ),
            ],
          ),
        ],
      ),
    );
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
