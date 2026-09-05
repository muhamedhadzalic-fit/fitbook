import '../models/enums.dart';
import '../models/reservation.dart';

/// Reservation-detail fixtures.
abstract final class MockReservationDetail {
  static const detail = ReservationDetail(
    reference: '#FB-2841',
    status: BookingStatus.confirmed,
    createdLabel: 'Created Apr 24, 09:42 · Last updated 2 min ago',
    sessionFields: [
      DetailField(label: 'Date & time', value: 'Apr 25, 2026 · 10:00 – 11:00'),
      DetailField(label: 'Duration', value: '60 minutes'),
      DetailField(label: 'Session type', value: 'In-person · 1-on-1'),
      DetailField(label: 'Booking channel', value: 'Mobile app (Android)'),
    ],
    client: Party(
      role: 'CLIENT',
      name: 'Amila Đedović',
      email: 'amila.djedovic@email.ba',
      phone: '+387 61 234 567',
      summary: 'Premium · Member since Jan 2025',
      identityHue: 280,
    ),
    trainer: Party(
      role: 'TRAINER',
      name: 'Marko Petrić',
      email: 'marko.petric@fitbook.ba',
      phone: '+387 61 998 110',
      summary: 'CrossFit, HIIT · 4.9 ★ (124)',
      identityHue: 215,
    ),
    locationFields: [
      DetailField(label: 'Location', value: 'Olympic Gym — Skenderija'),
      DetailField(label: 'Address', value: 'Terezije bb, 71000 Sarajevo'),
      DetailField(label: 'Room', value: 'Studio 2 — Strength'),
      DetailField(label: 'Equipment', value: 'Olympic barbell, kettlebells'),
    ],
    clientNotes:
        'Recovering from a minor lower-back strain — please keep deadlifts '
        'light. Goal for this block is squat strength + general conditioning.',
    auditTrail: [
      AuditEvent(
        action: 'Trainer checked in',
        timestamp: 'Apr 25, 09:58',
        actor: 'Marko Petrić',
        tintKey: 'blue',
      ),
      AuditEvent(
        action: 'Reminder sent to client',
        timestamp: 'Apr 25, 09:55',
        actor: 'System',
        tintKey: null,
      ),
      AuditEvent(
        action: 'Payment captured · 45.00 KM',
        timestamp: 'Apr 24, 14:08',
        actor: 'Stripe',
        tintKey: 'green',
      ),
      AuditEvent(
        action: 'Booking confirmed by trainer',
        timestamp: 'Apr 24, 09:43',
        actor: 'Marko Petrić',
        tintKey: 'green',
      ),
      AuditEvent(
        action: 'Booking created',
        timestamp: 'Apr 24, 09:42',
        actor: 'Amila Đedović',
        tintKey: null,
      ),
    ],
    payment: CapturedPayment(
      lines: [
        PaymentLine(label: 'Session', amountLabel: '45.00 KM'),
        PaymentLine(label: 'Platform fee', amountLabel: '0.00 KM'),
        PaymentLine(
          label: 'Promo: REPEAT5',
          amountLabel: '−2.25 KM',
          isCredit: true,
        ),
      ],
      totalLabel: '42.75 KM',
      cardBrand: 'VISA',
      maskedNumber: '•••• 4821',
      capturedAt: 'Captured Apr 24, 14:08',
      badge: 'PAID',
    ),
    readOnlyExplanation:
        'This booking is live and confirmed. To modify it, the client or '
        'trainer must request a change through the app — admins can intervene '
        'with an audit-logged override.',
    adminActions: [
      'Send message to client',
      'Reassign trainer',
      'Cancel booking (admin)',
    ],
  );

  static const bookingIdLabel = 'BOOKING ID';
  static const totalCaption = 'Total charged';
  static const partiesHeading = 'Parties';
  static const locationHeading = 'Location & notes';
  static const notesLabel = 'CLIENT NOTES';
  static const auditHeading = 'Audit trail';
  static const paymentHeading = 'Payment';
  static const readOnlyHeading = 'Read-only view';
  static const printLabel = 'Print';
  static const exportLabel = 'Export PDF';
}
