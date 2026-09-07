import 'enums.dart';

/// A booking row in the admin tables.
class ReservationRow {
  const ReservationRow({
    required this.reference,
    required this.clientName,
    required this.clientHue,
    required this.trainerName,
    required this.trainerHue,
    required this.dateLabel,
    required this.location,
    required this.status,
    required this.amount,
  });

  final String reference;
  final String clientName;
  final double clientHue;
  final String trainerName;
  final double trainerHue;
  final String dateLabel;
  final String location;
  final BookingStatus status;
  final int amount;
}

/// A status tab above a reservation table.
class StatusTab {
  const StatusTab({required this.label, required this.count});

  final String label;
  final int count;
}

/// A read-only key/value pair in the detail view.
class DetailField {
  const DetailField({required this.label, required this.value});

  final String label;
  final String value;
}

/// A client or trainer as shown on the reservation detail screen.
class Party {
  const Party({
    required this.role,
    required this.name,
    required this.email,
    required this.phone,
    required this.summary,
    required this.identityHue,
  });

  final String role;
  final String name;
  final String email;
  final String phone;
  final String summary;
  final double identityHue;
}

/// One entry in the booking's audit trail.
///
/// Every status transition writes one of these — who acted, when, and why.
class AuditEvent {
  const AuditEvent({
    required this.action,
    required this.timestamp,
    required this.actor,
    required this.tintKey,
  });

  final String action;
  final String timestamp;

  /// Who caused it — a person's name, "System", or a provider like "Stripe".
  final String actor;

  /// Semantic tint name: 'green', 'blue' or null for neutral.
  final String? tintKey;
}

/// A line on the payment breakdown.
class PaymentLine {
  const PaymentLine({
    required this.label,
    required this.amountLabel,
    this.isCredit = false,
  });

  final String label;
  final String amountLabel;
  final bool isCredit;
}

/// The captured payment.
class CapturedPayment {
  const CapturedPayment({
    required this.lines,
    required this.totalLabel,
    required this.cardBrand,
    required this.maskedNumber,
    required this.capturedAt,
    required this.badge,
  });

  final List<PaymentLine> lines;
  final String totalLabel;
  final String cardBrand;
  final String maskedNumber;
  final String capturedAt;
  final String badge;
}

/// The full read-only reservation detail.
class ReservationDetail {
  const ReservationDetail({
    required this.reference,
    required this.status,
    required this.createdLabel,
    required this.sessionFields,
    required this.client,
    required this.trainer,
    required this.locationFields,
    required this.clientNotes,
    required this.auditTrail,
    required this.payment,
    required this.readOnlyExplanation,
    required this.adminActions,
  });

  final String reference;
  final BookingStatus status;
  final String createdLabel;
  final List<DetailField> sessionFields;
  final Party client;
  final Party trainer;
  final List<DetailField> locationFields;
  final String clientNotes;
  final List<AuditEvent> auditTrail;
  final CapturedPayment payment;

  /// Why this view is read-only — admins observe bookings, trainers change
  /// them.
  final String readOnlyExplanation;

  /// Audit-logged overrides an admin may still perform.
  final List<String> adminActions;
}
