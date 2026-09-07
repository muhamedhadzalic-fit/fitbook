import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';
import 'profile_screen.dart';
import 'trainer_bookings_screen.dart';
import 'trainer_report_screen.dart';

/// The signed-in trainer's app.
///
/// Three tabs rather than the client's four: the design reuses one `BottomNav`
/// across every artboard, but a trainer has no reason to browse the trainer
/// search feed or their own recommendations. Bookings is the landing tab, which
/// is what both trainer artboards show as active.
class TrainerShell extends StatefulWidget {
  const TrainerShell({super.key, required this.onSignOut});

  final VoidCallback onSignOut;

  @override
  State<TrainerShell> createState() => _TrainerShellState();
}

class _TrainerShellState extends State<TrainerShell> {
  String _tab = MockSession.trainerLandingTab;

  List<NavDestination> get _destinations => MockSession.trainerNavDestinations;

  int get _tabIndex {
    final i = _destinations.indexWhere((d) => d.id == _tab);
    return i < 0 ? 0 : i;
  }

  void _selectTab(String id) => setState(() => _tab = id);

  Future<void> _handleProfileRow(SettingsRow row) async {
    switch (row.id) {
      case 'bookings':
        _selectTab('bookings');
      case 'signout':
        final confirmed = await showFBConfirm(
          context,
          title: MockSession.signOutTitle,
          body: MockSession.signOutBody,
          cancelLabel: MockSession.signOutCancel,
          confirmLabel: MockSession.signOutConfirm,
          isDestructive: true,
        );
        if (confirmed) widget.onSignOut();
      default:
        await showFBNotBuilt(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FBColors.bg,
      body: IndexedStack(
        index: _tabIndex,
        children: [
          const TrainerBookingsScreen(),
          const TrainerReportScreen(),
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
