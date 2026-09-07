import '../models/dashboard.dart';
import '../models/enums.dart';
import '../models/reservation.dart';

/// Reservation fixtures for the dashboard table and the reservations screen.
abstract final class MockReservations {
  static const rows = <ReservationRow>[
    ReservationRow(
      reference: '#FB-2841',
      clientName: 'Amila Đedović',
      clientHue: 280,
      trainerName: 'Marko Petrić',
      trainerHue: 215,
      dateLabel: 'Apr 25, 10:00',
      location: 'Olympic Gym',
      status: BookingStatus.confirmed,
      amount: 45,
    ),
    ReservationRow(
      reference: '#FB-2840',
      clientName: 'Haris Tabaković',
      clientHue: 50,
      trainerName: 'Ana Kovač',
      trainerHue: 320,
      dateLabel: 'Apr 25, 11:30',
      location: 'Studio Centar',
      status: BookingStatus.pending,
      amount: 35,
    ),
    ReservationRow(
      reference: '#FB-2839',
      clientName: 'Edin Mehmedović',
      clientHue: 145,
      trainerName: 'Iva Milić',
      trainerHue: 30,
      dateLabel: 'Apr 25, 14:00',
      location: 'BBI Fitness',
      status: BookingStatus.rejected,
      amount: 40,
    ),
    ReservationRow(
      reference: '#FB-2838',
      clientName: 'Selma Hadžić',
      clientHue: 320,
      trainerName: 'Damir Jurić',
      trainerHue: 5,
      dateLabel: 'Apr 25, 17:00',
      location: 'Olympic Gym',
      status: BookingStatus.confirmed,
      amount: 50,
    ),
    ReservationRow(
      reference: '#FB-2837',
      clientName: 'Vedran Knežević',
      clientHue: 195,
      trainerName: 'Tarik Bešić',
      trainerHue: 145,
      dateLabel: 'Apr 25, 18:30',
      location: 'Vilsonovo',
      status: BookingStatus.completed,
      amount: 35,
    ),
    ReservationRow(
      reference: '#FB-2836',
      clientName: 'Naida Pjanić',
      clientHue: 5,
      trainerName: 'Lejla Hodžić',
      trainerHue: 280,
      dateLabel: 'Apr 26, 09:00',
      location: 'Studio Centar',
      status: BookingStatus.confirmed,
      amount: 30,
    ),
    ReservationRow(
      reference: '#FB-2835',
      clientName: 'Adnan Begić',
      clientHue: 215,
      trainerName: 'Marko Petrić',
      trainerHue: 215,
      dateLabel: 'Apr 26, 10:30',
      location: 'Olympic Gym',
      status: BookingStatus.pending,
      amount: 45,
    ),
    ReservationRow(
      reference: '#FB-2834',
      clientName: 'Tea Šabić',
      clientHue: 30,
      trainerName: 'Ana Kovač',
      trainerHue: 320,
      dateLabel: 'Apr 26, 16:00',
      location: 'Studio Centar',
      status: BookingStatus.cancelled,
      amount: 35,
    ),
  ];

  /// The dashboard shows a shorter slice of the same data.
  static List<ReservationRow> get recent => rows.take(6).toList();

  static const kpis = <MiniKpi>[
    MiniKpi(label: 'Today', value: '86'),
    MiniKpi(label: 'Confirmed', value: '64', tintKey: 'green'),
    MiniKpi(label: 'Pending', value: '14', tintKey: 'amber'),
    MiniKpi(label: 'Rejected', value: '5', tintKey: 'red'),
    MiniKpi(label: 'Revenue today', value: '3,420 KM', tintKey: 'blue'),
  ];

  static const searchHint = 'Search by booking ID, client or trainer…';

  /// Dropdown filters. Values come from the DB in the real app — cities and
  /// statuses are never free-text.
  static const filters = <String>[
    'All statuses',
    'All trainers',
    'All locations',
    'Last 30 days',
  ];

  static const tabs = <StatusTab>[
    StatusTab(label: 'All', count: 248),
    StatusTab(label: 'Pending', count: 14),
    StatusTab(label: 'Confirmed', count: 198),
    StatusTab(label: 'Rejected', count: 12),
    StatusTab(label: 'Completed', count: 24),
  ];

  static const pageSizeNote = 'Showing 1–8 of 248 reservations';

  /// Pager position. The real list is paginated server-side with an enforced
  /// max page size, so these arrive with the page rather than being computed
  /// from a full result set the client never receives.
  static const pageCount = 3;
  static const currentPage = 1;

  static const emptyMessage = 'No reservations match this search';
  static const viewTooltip = 'View reservation';
  static const moreTooltip = 'More';
}
