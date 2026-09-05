import '../models/enums.dart';
import '../models/reservation.dart';

/// Reservation fixtures for the booking-confirmation and history screens.
abstract final class MockReservations {
  static const draft = BookingDraft(
    dateLabel: 'Friday, May 2',
    timeLabel: '10:00 — 11:00 AM',
    location: 'Olympic Gym · Marijin Dvor',
    spotsLabel: '3 of 6',
    notes: 'Recovering from a knee strain — please ease into squats.',
    membership: MembershipSummary(
      tier: 'Membership',
      detail: 'Premium · 8 sessions remaining · expires Aug 14',
      badge: 'ACTIVE',
    ),
    confirmWindow: '12h',
  );

  static const history = ReservationHistory(
    totalLabel: '24 total · 2 upcoming',
    submittedToast: SubmittedToast(
      title: 'Reservation submitted',
      body: 'Marko has up to 12h to confirm. You\'ll get a notification.',
    ),
    tabs: [
      ReservationTab(id: 'upcoming', label: 'Upcoming', count: 3),
      ReservationTab(id: 'past', label: 'Past', count: 21),
      ReservationTab(id: 'cancelled', label: 'Cancelled', count: 2),
    ],
    byTab: {
      'upcoming': [
        Reservation(
          reference: '#FB-2841',
          trainerName: 'Marko Petrić',
          trainerHue: 215,
          specialities: ['CrossFit', 'HIIT'],
          dateLabel: 'Fri, May 22',
          timeLabel: '10:00 – 11:00 AM',
          location: 'Olympic Gym · Marijin Dvor',
          amount: 45,
          status: BookingStatus.pending,
          membershipNote: 'Premium · 7 sessions left',
          isJustCreated: true,
        ),
        Reservation(
          reference: '#FB-2828',
          trainerName: 'Ana Kovač',
          trainerHue: 320,
          specialities: ['Yoga'],
          dateLabel: 'Sat, May 23',
          timeLabel: '09:00 – 10:00 AM',
          location: 'Studio Centar',
          amount: 35,
          status: BookingStatus.confirmed,
          membershipNote: 'Premium · 7 sessions left',
        ),
        Reservation(
          reference: '#FB-2820',
          trainerName: 'Tarik Bešić',
          trainerHue: 145,
          specialities: ['Running'],
          dateLabel: 'Mon, May 25',
          timeLabel: '06:30 – 07:30 AM',
          location: 'Vilsonovo šetalište',
          amount: 35,
          status: BookingStatus.confirmed,
        ),
      ],
      'past': [
        Reservation(
          reference: '#FB-2789',
          trainerName: 'Marko Petrić',
          trainerHue: 215,
          specialities: ['CrossFit'],
          dateLabel: 'Wed, May 14',
          timeLabel: '10:00 – 11:00 AM',
          location: 'Olympic Gym',
          amount: 45,
          status: BookingStatus.completed,
        ),
        Reservation(
          reference: '#FB-2766',
          trainerName: 'Ana Kovač',
          trainerHue: 320,
          specialities: ['Yoga'],
          dateLabel: 'Sat, May 10',
          timeLabel: '09:00 – 10:00 AM',
          location: 'Studio Centar',
          amount: 35,
          status: BookingStatus.completed,
        ),
        Reservation(
          reference: '#FB-2755',
          trainerName: 'Iva Milić',
          trainerHue: 30,
          specialities: ['Strength'],
          dateLabel: 'Wed, May 7',
          timeLabel: '17:00 – 18:00',
          location: 'BBI Fitness',
          amount: 40,
          status: BookingStatus.completed,
        ),
      ],
      'cancelled': [
        Reservation(
          reference: '#FB-2705',
          trainerName: 'Iva Milić',
          trainerHue: 30,
          specialities: ['Strength'],
          dateLabel: 'Apr 28',
          timeLabel: '17:00 – 18:00',
          location: 'BBI Fitness',
          amount: 40,
          status: BookingStatus.cancelled,
          cancellationReason: 'Trainer unavailable — refunded',
        ),
      ],
    },
  );
}
