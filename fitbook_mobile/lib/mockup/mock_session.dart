import '../models/home_feed.dart';

/// Fixtures for the app shell: what each role's navigation offers, and the
/// copy shown when a route has no screen behind it yet.
///
/// A real session comes from the JWT — role, display name, token expiry. Until
/// auth lands the shell reads the role from here and from whichever button the
/// user pressed on the welcome screen.
abstract final class MockSession {
  /// The trainer's navigation.
  ///
  /// Deliberately not the client's four tabs: the design reuses one `BottomNav`
  /// across every artboard, but a trainer has no reason to browse the trainer
  /// search feed. Bookings is the landing tab, matching the design's
  /// `BottomNav active="bookings"` on both trainer screens.
  static const trainerNavDestinations = <NavDestination>[
    NavDestination(id: 'bookings', label: 'Bookings', iconKey: 'calendar'),
    NavDestination(id: 'report', label: 'Report', iconKey: 'chart'),
    NavDestination(id: 'profile', label: 'Profile', iconKey: 'user'),
  ];

  /// Landing tab per role.
  static const clientLandingTab = 'home';
  static const trainerLandingTab = 'bookings';

  /// Shown when a profile row points at a screen that is not built yet.
  ///
  /// Every row stays tappable on purpose — a dead tap reads as a broken app,
  /// and the desktop shell solves the same problem with `placeholder_screen`.
  static const notBuiltTitle = 'Not built yet';
  static const notBuiltBody =
      'This screen is part of the design but has no implementation yet. '
      'Everything else in the app is reachable from the tab bar.';
  static const notBuiltDismiss = 'Got it';

  /// Confirmation before dropping the session.
  static const signOutTitle = 'Sign out?';
  static const signOutBody =
      'You will be returned to the welcome screen. Nothing is stored yet — '
      'this app runs entirely on mock data.';
  static const signOutCancel = 'Stay signed in';
  static const signOutConfirm = 'Sign out';
}
