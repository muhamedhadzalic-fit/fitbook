import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// Column definition for the reservation tables.
///
/// Shared between the dashboard's "recent reservations" panel and the full
/// reservations screen, so the two never drift apart.
/// The design's reservations table offers inline approve/reject on pending
/// rows. That conflicts with a settled decision — trainers confirm and reject
/// their own bookings, admins only observe — so the action column here is
/// view-only. Admin intervention lives on the detail screen as an
/// audit-logged override.
List<TableColumnSpec<ReservationRow>> reservationColumns({
  ValueChanged<ReservationRow>? onView,
}) {
  return [
    TableColumnSpec(
      header: 'BOOKING',
      width: const FixedWidth(96),
      build: (context, row) => Text(
        row.reference,
        style: FBText.mono.copyWith(fontSize: 11, color: FBColors.textMid),
      ),
    ),
    TableColumnSpec(
      header: 'CLIENT',
      width: const FlexWidth(1.4),
      build: (context, row) => TableIdentityCell(
        avatar: FBAvatar(name: row.clientName, hue: row.clientHue, size: 26),
        primary: row.clientName,
      ),
    ),
    TableColumnSpec(
      header: 'TRAINER',
      width: const FlexWidth(1.4),
      build: (context, row) => TableIdentityCell(
        avatar: FBAvatar(name: row.trainerName, hue: row.trainerHue, size: 26),
        primary: row.trainerName,
        primaryWeight: FontWeight.w500,
      ),
    ),
    TableColumnSpec(
      header: 'DATE & TIME',
      width: const FlexWidth(1.2),
      build: (context, row) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(row.dateLabel, style: FBText.label),
          const SizedBox(height: 1),
          Text(
            row.location,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: FBText.micro.copyWith(
              fontWeight: FontWeight.w500,
              color: FBColors.textDim,
            ),
          ),
        ],
      ),
    ),
    TableColumnSpec(
      header: 'STATUS',
      width: const FixedWidth(112),
      build: (context, row) => FBBadge.forStatus(row.status),
    ),
    TableColumnSpec(
      header: 'AMOUNT',
      width: const FixedWidth(80),
      alignment: Alignment.centerRight,
      build: (context, row) => Text(
        '${row.amount} KM',
        style: FBText.label.copyWith(
          fontWeight: FontWeight.w700,
          color: FBColors.navy,
        ),
      ),
    ),
    TableColumnSpec(
      header: 'ACTIONS',
      width: const FixedWidth(68),
      alignment: Alignment.centerRight,
      build: (context, row) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TableActionButton(
            icon: FBIcons.eye,
            tooltip: MockReservations.viewTooltip,
            onPressed: onView == null ? null : () => onView(row),
          ),
          const SizedBox(width: 4),
          const TableActionButton(
            icon: FBIcons.more,
            tooltip: MockReservations.moreTooltip,
          ),
        ],
      ),
    ),
  ];
}
