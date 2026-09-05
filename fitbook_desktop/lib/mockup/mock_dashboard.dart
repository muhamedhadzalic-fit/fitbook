import '../models/dashboard.dart';

/// Dashboard fixtures.
abstract final class MockDashboard {
  static const dashboard = AdminDashboard(
    subtitle: 'Overview · Last updated 2 minutes ago',
    searchHint: 'Search clients, trainers, bookings…',
    // The design draws ⌘K because it renders in a browser on macOS; this app
    // ships on Windows only, so the keycap names the key an admin actually has.
    searchShortcut: 'Ctrl K',
    primaryAction: 'New booking',
    kpis: [
      KpiMetric(
        label: 'Active Members',
        value: '1,248',
        delta: '+12.4%',
        tintHue: 195,
        trendUp: true,
      ),
      KpiMetric(
        label: 'Today\'s Bookings',
        value: '86',
        delta: '+5 vs avg',
        tintHue: 145,
        trendUp: true,
      ),
      KpiMetric(
        label: 'Monthly Revenue',
        value: '48,320 KM',
        delta: '+8.1%',
        tintHue: 50,
        trendUp: true,
      ),
      KpiMetric(
        label: 'Active Trainers',
        value: '34',
        delta: '2 pending',
        tintHue: 280,
      ),
    ],
    chart: BookingsChart(
      title: 'Bookings · Last 7 days',
      subtitle: '447 total · avg 64/day',
      labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      values: [42, 58, 51, 64, 72, 86, 74],
      maxValue: 100,
      ranges: ['7D', '30D', '90D'],
      selectedRange: '7D',
      highlightIndex: 5,
      highlightCaption: 'Sat, Apr 26',
    ),
    rankingTitle: 'Top trainers this week',
    rankings: [
      TrainerRanking(
        name: 'Marko Petrić',
        speciality: 'CrossFit',
        sessions: 42,
        identityHue: 215,
      ),
      TrainerRanking(
        name: 'Ana Kovač',
        speciality: 'Yoga',
        sessions: 38,
        identityHue: 320,
      ),
      TrainerRanking(
        name: 'Damir Jurić',
        speciality: 'Boxing',
        sessions: 31,
        identityHue: 5,
      ),
      TrainerRanking(
        name: 'Tarik Bešić',
        speciality: 'Running',
        sessions: 24,
        identityHue: 145,
      ),
    ],
  );

  static const recentTitle = 'Recent reservations';
  static const recentSubtitle = 'Today, April 25 · 86 total';
}
