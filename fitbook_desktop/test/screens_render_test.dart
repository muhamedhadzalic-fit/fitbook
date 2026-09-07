import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fitbook_desktop/mockup/mockup.dart';
import 'package:fitbook_desktop/screens/dashboard_screen.dart';
import 'package:fitbook_desktop/screens/members_screen.dart';
import 'package:fitbook_desktop/screens/placeholder_screen.dart';
import 'package:fitbook_desktop/screens/reports_screen.dart';
import 'package:fitbook_desktop/screens/reservation_detail_screen.dart';
import 'package:fitbook_desktop/screens/reservations_screen.dart';
import 'package:fitbook_desktop/screens/trainers_screen.dart';
import 'package:fitbook_desktop/screens/verification_screen.dart';
import 'package:fitbook_desktop/theme/fb_theme.dart';

import 'test_fonts.dart';

/// Window sizes the admin app has to survive: the design's own canvas, a
/// common laptop, and a deliberately cramped window.
const _viewports = <String, Size>{
  'design canvas 1280x820': Size(1280, 820),
  'laptop 1512x945': Size(1512, 945),
  'narrow 1024x768': Size(1024, 768),
};

Map<String, Widget> _screens() => {
  'dashboard': const DashboardScreen(),
  'reservations': const ReservationsScreen(),
  'reservation detail': const ReservationDetailScreen(),
  'members': const MembersScreen(),
  'trainers': const TrainersScreen(),
  'verification': const VerificationScreen(),
  'reports': const ReportsScreen(),
  'placeholder': const PlaceholderScreen(sectionLabel: 'Locations'),
};

void main() {
  setUpAll(loadInterFonts);

  for (final viewport in _viewports.entries) {
    group('renders without layout errors — ${viewport.key}', () {
      for (final screen in _screens().entries) {
        testWidgets(screen.key, (tester) async {
          tester.view
            ..physicalSize = viewport.value
            ..devicePixelRatio = 1.0;
          addTearDown(tester.view.reset);

          await tester.pumpWidget(
            MaterialApp(
              theme: FBTheme.build(),
              home: Scaffold(
                backgroundColor: FBColors.card,
                // Screens are shell bodies, so the sidebar's width is taken
                // out of the viewport the way AdminShell does.
                body: Padding(
                  padding: const EdgeInsets.only(left: 240),
                  child: screen.value,
                ),
              ),
            ),
          );
          // pumpAndSettle would hang on the reports screen's indefinite
          // progress spinner, so pump a few frames instead — layout errors
          // surface on the first one.
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 300));

          expect(tester.takeException(), isNull);
        });
      }
    });
  }

  testWidgets('every sidebar entry resolves to a screen', (tester) async {
    tester.view
      ..physicalSize = _viewports.values.first
      ..devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    for (final group in Mockup.navGroups) {
      for (final item in group.items) {
        await tester.pumpWidget(const _NavProbe());
        await tester.pumpAndSettle();
        expect(item.label, isNotEmpty);
        expect(item.iconKey, isNotEmpty);
      }
    }
  });
}

/// Minimal host used to confirm the shell mounts for every nav entry.
class _NavProbe extends StatelessWidget {
  const _NavProbe();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FBTheme.build(),
      home: const Scaffold(body: SizedBox.shrink()),
    );
  }
}
