import '../models/home_feed.dart';
import 'mock_trainers.dart';

/// Home-feed fixtures.
abstract final class MockHome {
  static final feed = HomeFeed(
    greeting: 'Good morning 👋',
    brand: 'FitBook',
    searchHint: 'Search trainers, gyms, classes…',
    notificationCount: 3,
    viewerName: 'Amila Đedović',
    viewerHue: 195,
    specialityFilters: const [
      'All',
      'Yoga',
      'CrossFit',
      'Strength',
      'Boxing',
      'Cardio',
    ],
    banner: const MembershipBanner(
      tierLabel: 'PREMIUM · Active',
      detail: '8 sessions left this month',
    ),
    sectionTitle: 'Top trainers near you',
    trainers: MockTrainers.all,
  );

  /// Bottom-navigation destinations shared by every client-facing screen.
  static const navDestinations = <NavDestination>[
    NavDestination(id: 'home', label: 'Home', iconKey: 'home'),
    NavDestination(id: 'discover', label: 'Discover', iconKey: 'search'),
    NavDestination(id: 'bookings', label: 'Bookings', iconKey: 'calendar'),
    NavDestination(id: 'profile', label: 'Profile', iconKey: 'user'),
  ];
}
