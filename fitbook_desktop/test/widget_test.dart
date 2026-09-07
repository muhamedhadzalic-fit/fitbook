import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fitbook_desktop/main.dart';
import 'package:fitbook_desktop/mockup/mockup.dart';
import 'package:fitbook_desktop/screens/reservations_screen.dart';
import 'package:fitbook_desktop/screens/trainers_screen.dart';
import 'package:fitbook_desktop/theme/fb_theme.dart';
import 'package:fitbook_desktop/widgets/widgets.dart';

import 'test_fonts.dart';

/// A window large enough for the desktop layout.
const _windowSize = Size(1440, 900);

/// Hosts a screen body the way [AdminShell] does — the screens under
/// `lib/screens/` are bodies, not standalone routes, so they need a Scaffold.
Widget _host(Widget body) => MaterialApp(
  theme: FBTheme.build(),
  home: Scaffold(backgroundColor: FBColors.card, body: body),
);

Future<void> _pumpDesktop(WidgetTester tester, Widget app) async {
  tester.view
    ..physicalSize = _windowSize
    ..devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(app);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadInterFonts);

  testWidgets('admin app opens on the dashboard', (tester) async {
    await _pumpDesktop(tester, const FitBookAdminApp());

    expect(find.text('Dashboard'), findsWidgets);
    expect(find.text(Mockup.admin.name), findsOneWidget);
    for (final kpi in Mockup.dashboard.kpis) {
      // Scoped to the KPI cards — "34" also appears as a sidebar badge.
      expect(
        find.descendant(
          of: find.byType(KpiCard),
          matching: find.text(kpi.value),
        ),
        findsOneWidget,
      );
    }
  });

  testWidgets('sidebar navigates to the verification queue', (tester) async {
    await _pumpDesktop(tester, const FitBookAdminApp());

    await tester.tap(find.text('Verifications'));
    await tester.pumpAndSettle();

    expect(find.text(MockVerification.queueHeading), findsOneWidget);
    for (final application in Mockup.verificationQueue) {
      expect(find.text(application.name), findsWidgets);
    }
  });

  testWidgets('rejecting an application requires a reason', (tester) async {
    await _pumpDesktop(tester, const FitBookAdminApp());

    await tester.tap(find.text('Verifications'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(MockVerification.actions.reject));
    await tester.pumpAndSettle();

    expect(
      find.text('A reason is required before rejecting an application.'),
      findsOneWidget,
    );

    // With no reason entered the confirm button is disabled.
    final rejectButton = tester.widget<FBButton>(
      find.widgetWithText(FBButton, 'Reject'),
    );
    expect(rejectButton.onPressed, isNull);

    await tester.enterText(find.byType(TextField), 'Certification unverified');
    await tester.pumpAndSettle();

    final enabled = tester.widget<FBButton>(
      find.widgetWithText(FBButton, 'Reject'),
    );
    expect(enabled.onPressed, isNotNull);
  });

  testWidgets('reservations list filters by search query', (tester) async {
    await _pumpDesktop(tester, _host(const ReservationsScreen()));

    expect(find.text('Amila Đedović'), findsOneWidget);
    expect(find.text('Tea Šabić'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'tea');
    await tester.pumpAndSettle();

    expect(find.text('Tea Šabić'), findsOneWidget);
    expect(find.text('Amila Đedović'), findsNothing);
  });

  testWidgets('a trainer with active bookings cannot be deleted', (
    tester,
  ) async {
    await _pumpDesktop(tester, _host(const TrainersScreen()));

    final blocked = Mockup.trainers.firstWhere((t) => t.activeBookings > 0);
    final deletable = Mockup.trainers.firstWhere((t) => t.canDelete);

    final deleteButtons = find.byWidgetPredicate(
      (w) => w is TableActionButton && w.icon == FBIcons.trash,
    );
    final buttons = tester.widgetList<TableActionButton>(deleteButtons);

    expect(
      buttons.where((b) => b.isDisabled).length,
      Mockup.trainers.where((t) => !t.canDelete).length,
      reason: 'delete is disabled for every trainer with active bookings',
    );
    expect(blocked.canDelete, isFalse);
    expect(deletable.canDelete, isTrue);
  });

  testWidgets('mock data carries no placeholder text', (tester) async {
    // Guards against a fixture shipping a lorem-ipsum or TODO string.
    final samples = <String>[
      for (final r in Mockup.reservations) r.clientName,
      for (final m in Mockup.members) m.email,
      for (final t in Mockup.trainers) t.name,
      for (final a in Mockup.verificationQueue) a.bio,
    ];
    for (final sample in samples) {
      expect(sample.toLowerCase(), isNot(contains('lorem')));
      expect(sample.toLowerCase(), isNot(contains('todo')));
      expect(sample.trim(), isNotEmpty);
    }
  });
}
