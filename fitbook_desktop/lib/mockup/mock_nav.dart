import '../models/nav.dart';

/// Sidebar and identity fixtures.
abstract final class MockNav {
  static const admin = AdminIdentity(
    name: 'Selma Bektaš',
    role: 'Super Admin',
    identityHue: 280,
  );

  static const branding = AdminBranding(
    appName: 'FitBook',
    appSubtitle: 'Admin Panel v2.4',
  );

  static const groups = <NavGroup>[
    NavGroup(
      label: 'OVERVIEW',
      items: [
        NavItem(id: 'dashboard', label: 'Dashboard', iconKey: 'home'),
        NavItem(
          id: 'bookings',
          label: 'Bookings',
          iconKey: 'calendar',
          badge: '14',
        ),
        NavItem(
          id: 'members',
          label: 'Members',
          iconKey: 'users',
          badge: '248',
        ),
        NavItem(
          id: 'trainers',
          label: 'Trainers',
          iconKey: 'dumbbell',
          badge: '34',
        ),
      ],
    ),
    NavGroup(
      label: 'OPERATIONS',
      items: [
        NavItem(
          id: 'verify',
          label: 'Verifications',
          iconKey: 'check',
          badge: '4',
        ),
        NavItem(
          id: 'locations',
          label: 'Locations',
          iconKey: 'pin',
          isImplemented: false,
        ),
        NavItem(
          id: 'notifications',
          label: 'Notifications',
          iconKey: 'bell',
          isImplemented: false,
        ),
        NavItem(
          id: 'payments',
          label: 'Payments',
          iconKey: 'money',
          isImplemented: false,
        ),
        NavItem(id: 'reports', label: 'Reports', iconKey: 'chart'),
      ],
    ),
    NavGroup(
      label: 'SYSTEM',
      items: [
        NavItem(
          id: 'settings',
          label: 'Settings',
          iconKey: 'settings',
          isImplemented: false,
        ),
      ],
    ),
  ];

  /// Title, breadcrumb and toolbar labels for each screen the shell hosts.
  ///
  /// Header copy is data, not layout, so `AdminApp` reads it from here rather
  /// than spelling out breadcrumbs inline.
  static const chrome = <String, ScreenChrome>{
    'dashboard': ScreenChrome(title: 'Dashboard'),
    'bookings': ScreenChrome(
      title: 'Reservations',
      breadcrumb: 'Admin · Operations · Reservations',
      actions: ['Filters', 'Export CSV'],
    ),
    'members': ScreenChrome(
      title: 'Members',
      breadcrumb: 'Admin · Users · Members',
      actions: ['Filters'],
    ),
    'trainers': ScreenChrome(
      title: 'Manage trainers',
      breadcrumb: 'Admin · Trainers',
    ),
    'verify': ScreenChrome(
      title: 'Trainer Verification',
      breadcrumb: 'Admin · Trainers · Verification',
    ),
    'reports': ScreenChrome(
      title: 'Reports',
      breadcrumb: 'Admin · System · Reports & PDF',
    ),
  };

  /// Header copy for the reservation detail view, which is reached by clicking
  /// a table row rather than a sidebar entry.
  static ScreenChrome reservationDetailChrome(String reference) => ScreenChrome(
    title: 'Reservation $reference',
    breadcrumb: 'Admin · Reservations · $reference',
    actions: ['Back to list'],
  );

  /// Breadcrumb for a section with no screen behind it.
  static const placeholderBreadcrumb = 'Admin';

  /// Copy shared by more than one admin screen.
  static const tableEmptyFallback = 'Nothing to show';
  static const filterLabel = 'Filter';
  static const exportLabel = 'Export';
  static const addMoreLabel = '+ Add…';

  /// Copy for a sidebar section that has no screen yet.
  static const placeholderTitle = 'Not built yet';
  static const placeholderBody =
      'This section is part of the design but has no screen implemented '
      'yet. Pick another entry from the sidebar.';
}
