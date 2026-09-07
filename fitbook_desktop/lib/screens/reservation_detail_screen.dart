import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 6.3b · Reservation detail (read-only) — the master-detail companion of the
/// reservations list.
///
/// Read-only by design: trainers own the booking's status transitions. An admin
/// can still intervene, but only through the audit-logged overrides on the
/// right-hand panel.
class ReservationDetailScreen extends StatelessWidget {
  const ReservationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final detail = Mockup.reservationDetail;

    return ListView(
      padding: const EdgeInsets.fromLTRB(28, 20, 28, 28),
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 900;
            final left = _MainColumn(detail: detail);
            final right = _SideColumn(detail: detail);

            if (isNarrow) {
              return Column(
                children: [left, const SizedBox(height: 14), right],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: left),
                const SizedBox(width: 14),
                SizedBox(width: 360, child: right),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _MainColumn extends StatelessWidget {
  const _MainColumn({required this.detail});

  final ReservationDetail detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StatusCard(detail: detail),
        const SizedBox(height: 14),
        FBCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FBHeading(MockReservationDetail.partiesHeading),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _PartyCard(party: detail.client)),
                  const SizedBox(width: 14),
                  Expanded(child: _PartyCard(party: detail.trainer)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        FBCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FBHeading(MockReservationDetail.locationHeading),
              _FieldGrid(fields: detail.locationFields, columns: 2),
              const SizedBox(height: 14),
              Text(
                MockReservationDetail.notesLabel,
                style: FBText.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: FBColors.textDim,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: FBColors.card,
                  borderRadius: FBRadius.all(FBRadius.control),
                  border: Border.all(color: FBColors.cardBorder),
                ),
                child: Text(
                  '“${detail.clientNotes}”',
                  style: FBText.body.copyWith(height: 1.55),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        FBCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FBHeading(MockReservationDetail.auditHeading),
              _Timeline(events: detail.auditTrail),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.detail});

  final ReservationDetail detail;

  @override
  Widget build(BuildContext context) {
    return FBCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MockReservationDetail.bookingIdLabel,
                      style: FBText.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                        color: FBColors.textDim,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      detail.reference,
                      style: FBText.mono.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: FBColors.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      detail.createdLabel,
                      style: FBText.label.copyWith(
                        fontWeight: FontWeight.w500,
                        color: FBColors.textMid,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              FBBadge.forStatus(detail.status),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          _FieldGrid(fields: detail.sessionFields, columns: 4),
        ],
      ),
    );
  }
}

class _FieldGrid extends StatelessWidget {
  const _FieldGrid({required this.fields, required this.columns});

  final List<DetailField> fields;
  final int columns;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < fields.length; i += columns) {
      final slice = fields.skip(i).take(columns).toList();
      rows.add(
        Padding(
          padding: EdgeInsets.only(top: i == 0 ? 0 : 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var c = 0; c < columns; c++) ...[
                if (c > 0) const SizedBox(width: 14),
                Expanded(
                  child: c < slice.length
                      ? FBReadField(
                          label: slice[c].label,
                          value: slice[c].value,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ),
        ),
      );
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows);
  }
}

class _PartyCard extends StatelessWidget {
  const _PartyCard({required this.party});

  final Party party;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: FBColors.card,
        borderRadius: FBRadius.all(FBRadius.button),
        border: Border.all(color: FBColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            party.role,
            style: FBText.micro.copyWith(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: FBColors.textDim,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              FBAvatar(name: party.name, hue: party.identityHue, size: 48),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      party.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: FBText.titleSm,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      party.summary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: FBText.caption.copyWith(color: FBColors.textDim),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _ContactLine(icon: FBIcons.mail, text: party.email),
          const SizedBox(height: 3),
          _ContactLine(icon: FBIcons.phone, text: party.phone),
        ],
      ),
    );
  }
}

class _ContactLine extends StatelessWidget {
  const _ContactLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12, color: FBColors.textMid),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: FBText.caption.copyWith(color: FBColors.textMid),
          ),
        ),
      ],
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.events});

  final List<AuditEvent> events;

  static Color _tint(String? key) => switch (key) {
    'green' => FBColors.green,
    'blue' => FBColors.blue,
    'red' => FBColors.red,
    _ => FBColors.textMid,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < events.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 22,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _tint(events[i].tintKey),
                            width: 2,
                          ),
                        ),
                      ),
                      if (i != events.length - 1)
                        Expanded(
                          child: Container(
                            width: 2,
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            color: FBColors.cardBorder,
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: i == events.length - 1 ? 0 : 14,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(events[i].action, style: FBText.label),
                        const SizedBox(height: 1),
                        Text(
                          '${events[i].timestamp} · ${events[i].actor}',
                          style: FBText.caption.copyWith(
                            color: FBColors.textDim,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _SideColumn extends StatelessWidget {
  const _SideColumn({required this.detail});

  final ReservationDetail detail;

  @override
  Widget build(BuildContext context) {
    final payment = detail.payment;

    return Column(
      children: [
        FBCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FBHeading(MockReservationDetail.paymentHeading),
              for (final line in payment.lines)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          line.label,
                          style: FBText.body.copyWith(
                            color: line.isCredit
                                ? FBColors.green
                                : FBColors.textMid,
                          ),
                        ),
                      ),
                      Text(
                        line.amountLabel,
                        style: FBText.body.copyWith(
                          color: line.isCredit ? FBColors.green : FBColors.text,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 4),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      MockReservationDetail.totalCaption,
                      style: FBText.label.copyWith(color: FBColors.textMid),
                    ),
                  ),
                  Text(
                    payment.totalLabel,
                    style: FBText.h2.copyWith(
                      fontWeight: FontWeight.w800,
                      color: FBColors.navy,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: FBColors.card,
                  borderRadius: FBRadius.all(FBRadius.control),
                  border: Border.all(color: FBColors.cardBorder),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 26,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: FBColors.navy,
                        borderRadius: FBRadius.all(4),
                      ),
                      child: Text(
                        payment.cardBrand,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(payment.maskedNumber, style: FBText.label),
                          Text(
                            payment.capturedAt,
                            style: FBText.micro.copyWith(
                              fontWeight: FontWeight.w500,
                              color: FBColors.textDim,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    FBBadge(
                      label: payment.badge,
                      background: FBColors.greenBg,
                      foreground: FBColors.green,
                      fontSize: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        FBCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FBHeading(MockReservationDetail.readOnlyHeading),
              Text(
                detail.readOnlyExplanation,
                style: FBText.body.copyWith(
                  color: FBColors.textMid,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 14),
              for (var i = 0; i < detail.adminActions.length; i++) ...[
                if (i > 0) const SizedBox(height: 8),
                FBButton(
                  label: detail.adminActions[i],
                  // The last action cancels the booking, so it reads
                  // destructive and would confirm before firing.
                  kind: i == detail.adminActions.length - 1
                      ? FBButtonKind.danger
                      : FBButtonKind.outline,
                  height: 40,
                  fontSize: 12,
                  radius: FBRadius.control,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
