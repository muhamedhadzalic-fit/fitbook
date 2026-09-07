import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';
import 'booking_screen.dart';
import 'chat_screen.dart';
import 'home_screen.dart';
import 'membership_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'recommendations_screen.dart';
import 'reservation_history_screen.dart';
import 'trainer_detail_screen.dart';

/// The signed-in client's app: four tabs, with detail screens pushed on top.
///
/// Navigation lives here rather than inside the screens, so each screen stays a
/// pure view over its mock data. When auth lands this is what the JWT's
/// `client` role routes to.
class ClientShell extends StatefulWidget {
  const ClientShell({super.key, required this.onSignOut});

  final VoidCallback onSignOut;

  @override
  State<ClientShell> createState() => _ClientShellState();
}

class _ClientShellState extends State<ClientShell> {
  String _tab = MockSession.clientLandingTab;

  /// Set after a booking is confirmed so the history tab flags the new row.
  bool _highlightNewBooking = false;

  List<NavDestination> get _destinations => Mockup.navDestinations;

  int get _tabIndex {
    final i = _destinations.indexWhere((d) => d.id == _tab);
    return i < 0 ? 0 : i;
  }

  void _selectTab(String id) => setState(() {
    _tab = id;
    // The highlight is a one-shot: leaving the tab and coming back should not
    // re-flag a booking the user has already seen.
    if (id != 'bookings') _highlightNewBooking = false;
  });

  Future<void> _push(Widget screen) =>
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (_) => screen));

  /// Trainer profile → reserve → confirm, then land on the history tab.
  void _openTrainer(Trainer trainer) {
    _push(
      TrainerDetailScreen(
        trainer: trainer,
        onBack: () => Navigator.of(context).pop(),
        onReserve: () => _openBooking(trainer),
      ),
    );
  }

  void _openBooking(Trainer trainer) {
    _push(
      BookingScreen(
        trainer: trainer,
        onBack: () => Navigator.of(context).pop(),
        onConfirmed: _onBookingConfirmed,
      ),
    );
  }

  /// Unwinds the detail/booking stack and drops the user on their reservations
  /// with the new one flagged — the journey the design's prototype ends on.
  void _onBookingConfirmed() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    setState(() {
      _highlightNewBooking = true;
      _tab = 'bookings';
    });
  }

  Future<void> _handleProfileRow(SettingsRow row) async {
    switch (row.id) {
      case 'membership':
        await _push(
          MembershipScreen(onBack: () => Navigator.of(context).pop()),
        );
      case 'notifications':
        await _push(
          NotificationsScreen(onBack: () => Navigator.of(context).pop()),
        );
      case 'bookings':
        _selectTab('bookings');
      case 'help':
        // FitBot is the app's support surface, so the help row is its entry
        // point. It is not the ML component — that is the Discover tab.
        await _push(ChatScreen(onBack: () => Navigator.of(context).pop()));
      case 'signout':
        await _confirmSignOut();
      default:
        await showFBNotBuilt(context);
    }
  }

  Future<void> _confirmSignOut() async {
    final confirmed = await showFBConfirm(
      context,
      title: MockSession.signOutTitle,
      body: MockSession.signOutBody,
      cancelLabel: MockSession.signOutCancel,
      confirmLabel: MockSession.signOutConfirm,
      isDestructive: true,
    );
    if (confirmed) widget.onSignOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FBColors.bg,
      // IndexedStack keeps each tab alive, so a search query or scroll position
      // survives a trip through another tab.
      body: IndexedStack(
        index: _tabIndex,
        children: [
          HomeScreen(
            onTrainerTap: _openTrainer,
            onNotifications: () => _push(
              NotificationsScreen(onBack: () => Navigator.of(context).pop()),
            ),
            onMembership: () => _push(
              MembershipScreen(onBack: () => Navigator.of(context).pop()),
            ),
          ),
          const RecommendationsScreen(),
          ReservationHistoryScreen(highlightNewest: _highlightNewBooking),
          ProfileScreen(onRowTap: _handleProfileRow),
        ],
      ),
      bottomNavigationBar: FBBottomNav(
        destinations: _destinations,
        activeId: _tab,
        onChanged: _selectTab,
      ),
    );
  }
}
