import 'enums.dart';

/// A booking from the client's point of view.
class Reservation {
  const Reservation({
    required this.reference,
    required this.trainerName,
    required this.trainerHue,
    required this.specialities,
    required this.dateLabel,
    required this.timeLabel,
    required this.location,
    required this.amount,
    required this.status,
    this.membershipNote,
    this.cancellationReason,
    this.isJustCreated = false,
  });

  final String reference;
  final String trainerName;
  final double trainerHue;
  final List<String> specialities;
  final String dateLabel;
  final String timeLabel;
  final String location;
  final int amount;
  final BookingStatus status;

  /// Set when the session is covered by an active membership.
  final String? membershipNote;

  /// Why the booking was cancelled or rejected.
  final String? cancellationReason;

  /// Highlights the booking the user has just submitted.
  final bool isJustCreated;
}

/// One tab in the reservation-history segmented control.
class ReservationTab {
  const ReservationTab({
    required this.id,
    required this.label,
    required this.count,
  });

  final String id;
  final String label;
  final int count;
}

/// The whole reservation-history payload the screen renders.
class ReservationHistory {
  const ReservationHistory({
    required this.totalLabel,
    required this.tabs,
    required this.byTab,
    required this.submittedToast,
  });

  final String totalLabel;
  final List<ReservationTab> tabs;
  final Map<String, List<Reservation>> byTab;
  final SubmittedToast submittedToast;
}

/// The confirmation banner shown after a booking is submitted.
class SubmittedToast {
  const SubmittedToast({required this.title, required this.body});

  final String title;
  final String body;
}

/// The read-only summary rows on the booking confirmation screen.
class BookingDraft {
  const BookingDraft({
    required this.dateLabel,
    required this.timeLabel,
    required this.location,
    required this.spotsLabel,
    required this.notes,
    required this.membership,
    required this.confirmWindow,
  });

  final String dateLabel;
  final String timeLabel;
  final String location;
  final String spotsLabel;
  final String notes;
  final MembershipSummary membership;

  /// How long the trainer has to respond, e.g. "12h".
  final String confirmWindow;
}

/// Compact membership state shown inline on the booking screen.
class MembershipSummary {
  const MembershipSummary({
    required this.tier,
    required this.detail,
    required this.badge,
  });

  final String tier;
  final String detail;
  final String badge;
}
