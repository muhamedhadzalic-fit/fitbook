import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';
import 'dashboard_screen.dart';
import 'members_screen.dart';
import 'placeholder_screen.dart';
import 'reports_screen.dart';
import 'reservation_detail_screen.dart';
import 'reservations_screen.dart';
import 'trainers_screen.dart';
import 'verification_screen.dart';

/// The admin app: one window, sidebar navigation, one screen at a time.
///
/// Navigation state lives here so each screen stays a pure view over its mock
/// data. Reservations and their detail view are a master-detail pair — opening a
/// row swaps the body and puts a back affordance in the header.
class AdminApp extends StatefulWidget {
  const AdminApp({super.key});

  @override
  State<AdminApp> createState() => _AdminAppState();
}

class _AdminAppState extends State<AdminApp> {
  final _trainersKey = GlobalKey<TrainersScreenState>();

  String _navId = 'dashboard';

  /// Non-null while the reservation detail view is open.
  ReservationRow? _openReservation;

  NavItem get _activeItem {
    for (final group in Mockup.navGroups) {
      for (final item in group.items) {
        if (item.id == _navId) return item;
      }
    }
    return Mockup.navGroups.first.items.first;
  }

  void _select(String id) => setState(() {
    _navId = id;
    _openReservation = null;
  });

  void _openReservationDetail(ReservationRow row) =>
      setState(() => _openReservation = row);

  void _closeReservationDetail() => setState(() => _openReservation = null);

  @override
  Widget build(BuildContext context) {
    final (title, breadcrumb, subtitle, actions, body) = _resolveScreen();

    return AdminShell(
      title: title,
      breadcrumb: breadcrumb,
      subtitle: subtitle,
      headerActions: actions,
      navGroups: Mockup.navGroups,
      activeNavId: _navId,
      admin: Mockup.admin,
      branding: Mockup.branding,
      onNavSelected: _select,
      child: body,
    );
  }

  /// Resolves the header and body for the current navigation state.
  ///
  /// Title and breadcrumb copy comes from `MockNav.chrome`; only the widgets
  /// are assembled here.
  (String, String?, String?, List<Widget>, Widget) _resolveScreen() {
    if (_openReservation != null) {
      final row = _openReservation!;
      final chrome = MockNav.reservationDetailChrome(row.reference);
      return (
        chrome.title,
        chrome.breadcrumb,
        null,
        [
          FBTextButton(
            label: chrome.actions.first,
            icon: FBIcons.back,
            onPressed: _closeReservationDetail,
          ),
          const FBTextButton(
            label: MockReservationDetail.printLabel,
            icon: FBIcons.print,
          ),
          const FBTextButton(
            label: MockReservationDetail.exportLabel,
            icon: FBIcons.download,
            isPrimary: true,
          ),
        ],
        const ReservationDetailScreen(),
      );
    }

    final chrome = MockNav.chrome[_navId];
    if (chrome == null) {
      return (
        _activeItem.label,
        MockNav.placeholderBreadcrumb,
        null,
        const <Widget>[],
        PlaceholderScreen(sectionLabel: _activeItem.label),
      );
    }

    return switch (_navId) {
      'dashboard' => (
        chrome.title,
        chrome.breadcrumb,
        Mockup.dashboard.subtitle,
        [
          FBGlobalSearch(
            hint: Mockup.dashboard.searchHint,
            shortcut: Mockup.dashboard.searchShortcut,
          ),
          FBTextButton(
            label: Mockup.dashboard.primaryAction,
            icon: FBIcons.plus,
            isPrimary: true,
          ),
          const FBIconButton(
            icon: FBIcons.bell,
            size: 36,
            iconSize: 16,
            dotColor: FBColors.red,
          ),
        ],
        DashboardScreen(onReservationTap: _openReservationDetail),
      ),
      'bookings' => (
        chrome.title,
        chrome.breadcrumb,
        null,
        [
          FBTextButton(label: chrome.actions[0], icon: FBIcons.filter),
          FBTextButton(
            label: chrome.actions[1],
            icon: FBIcons.download,
            isPrimary: true,
          ),
        ],
        ReservationsScreen(onOpenDetail: _openReservationDetail),
      ),
      'members' => (
        chrome.title,
        chrome.breadcrumb,
        null,
        [
          FBTextButton(label: chrome.actions.first, icon: FBIcons.filter),
          const FBTextButton(
            label: MockMembers.inviteLabel,
            icon: FBIcons.plus,
            isPrimary: true,
          ),
        ],
        const MembersScreen(),
      ),
      'trainers' => (
        chrome.title,
        chrome.breadcrumb,
        MockTrainers.rosterSummary(
          Mockup.trainers.length,
          MockTrainers.cityOptions.length - 1,
        ),
        [
          FBTextButton(
            label: MockTrainers.addLabel,
            icon: FBIcons.plus,
            isPrimary: true,
            onPressed: () => _trainersKey.currentState?.openCreateForm(),
          ),
        ],
        TrainersScreen(key: _trainersKey),
      ),
      'verify' => (
        chrome.title,
        chrome.breadcrumb,
        null,
        const <Widget>[],
        const VerificationScreen(),
      ),
      _ => (
        chrome.title,
        chrome.breadcrumb,
        null,
        const [
          FBTextButton(
            label: MockReports.newReportLabel,
            icon: FBIcons.plus,
            isPrimary: true,
          ),
        ],
        const ReportsScreen(),
      ),
    };
  }
}
