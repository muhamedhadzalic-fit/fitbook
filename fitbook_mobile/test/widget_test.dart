import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fitbook_mobile/main.dart';
import 'package:fitbook_mobile/mockup/mockup.dart';
import 'package:fitbook_mobile/screens/home_screen.dart';
import 'package:fitbook_mobile/screens/recommendations_screen.dart';
import 'package:fitbook_mobile/theme/fb_theme.dart';
import 'package:fitbook_mobile/widgets/widgets.dart';

import 'test_fonts.dart';

/// A typical Android phone viewport.
///
/// The flow tests need it: the default 800x600 test surface puts the
/// registration form's Continue button below the fold, so a tap misses it.
const _phone = Size(412, 915);

Future<void> _pumpApp(WidgetTester tester) async {
  tester.view
    ..physicalSize = _phone
    ..devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const FitBookApp());
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadInterFonts);

  testWidgets('app opens on the welcome screen, not a screen index', (
    tester,
  ) async {
    await _pumpApp(tester);

    expect(find.text(Mockup.welcome.headline), findsOneWidget);
    expect(find.text(Mockup.welcome.primaryCta), findsOneWidget);
    // No shell yet: the tab bar only exists once a session does.
    expect(find.byType(FBBottomNav), findsNothing);
  });

  testWidgets('signing in lands the client on the home tab', (tester) async {
    await _pumpApp(tester);

    await tester.tap(find.text(Mockup.welcome.secondaryCta));
    await tester.pumpAndSettle();

    expect(find.byType(FBBottomNav), findsOneWidget);
    for (final destination in Mockup.navDestinations) {
      expect(find.text(destination.label), findsWidgets);
    }
    expect(find.text(Mockup.home.sectionTitle), findsOneWidget);
  });

  testWidgets('registering as a trainer routes to the trainer shell', (
    tester,
  ) async {
    await _pumpApp(tester);

    await tester.tap(find.text(Mockup.welcome.primaryCta));
    await tester.pumpAndSettle();

    // Pick the trainer role, then continue.
    final trainerRole = Mockup.memberRegistration.roles
        .firstWhere((r) => r.id == 'trainer')
        .title;
    await tester.tap(find.text(trainerRole));
    await tester.pumpAndSettle();
    // Consent is pre-ticked in the fixture, so Continue is already enabled —
    // tapping the checkbox here would switch it off and disable the button.
    expect(
      tester.widget<FBCheckbox>(find.byType(FBCheckbox)).value,
      isTrue,
      reason: 'the fixture ships consent already given',
    );
    final submit = find.text(Mockup.memberRegistration.submitLabel);
    await tester.ensureVisible(submit);
    await tester.pumpAndSettle();
    await tester.tap(submit);
    await tester.pumpAndSettle();

    // Trainer application, then into the trainer's own workspace.
    expect(find.text(Mockup.trainerRegistration.stepTitle), findsOneWidget);
    // Both routes spell their primary action "Continue"; `.last` picks the
    // one on the route that was just pushed.
    final trainerContinue = find.text(MockChrome.continueLabel).last;
    await tester.ensureVisible(trainerContinue);
    await tester.pumpAndSettle();
    await tester.tap(trainerContinue);
    await tester.pumpAndSettle();

    expect(find.text(MockChrome.trainerBookingsTitle), findsOneWidget);
    // The trainer's nav is its own three tabs, not the client's four.
    expect(find.text('Discover'), findsNothing);
  });

  testWidgets('the client tab bar swaps the body', (tester) async {
    await _pumpApp(tester);
    await tester.tap(find.text(Mockup.welcome.secondaryCta));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text(Mockup.profile.name), findsWidgets);

    await tester.tap(find.text('Bookings'));
    await tester.pumpAndSettle();
    expect(find.text(MockChrome.reservationsTitle), findsOneWidget);
  });

  testWidgets('home screen filters trainers by speciality', (tester) async {
    await tester.pumpWidget(
      MaterialApp(theme: FBTheme.build(), home: const HomeScreen()),
    );

    expect(find.text('Ana Kovač'), findsOneWidget);
    expect(find.text('Damir Jurić'), findsOneWidget);

    // Target the filter chip, not Ana's speciality tag.
    await tester.tap(
      find.descendant(
        of: find.byType(FBChoiceChip),
        matching: find.text('Yoga'),
      ),
    );
    await tester.pumpAndSettle();

    // Ana teaches Yoga; Damir does not.
    expect(find.text('Ana Kovač'), findsOneWidget);
    expect(find.text('Damir Jurić'), findsNothing);
  });

  testWidgets('home screen filters trainers by search query', (tester) async {
    await tester.pumpWidget(
      MaterialApp(theme: FBTheme.build(), home: const HomeScreen()),
    );

    await tester.enterText(find.byType(TextField), 'tarik');
    await tester.pumpAndSettle();

    expect(find.text('Tarik Bešić'), findsOneWidget);
    expect(find.text('Ana Kovač'), findsNothing);
  });

  testWidgets('every recommendation states its weighted reason', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: FBTheme.build(), home: const RecommendationsScreen()),
    );

    final top = Mockup.recommendations.top;
    for (final reason in top.reasons) {
      expect(find.text(reason.label), findsOneWidget);
      expect(
        find.text('${(reason.weight * 100).round()}%'),
        findsWidgets,
        reason: 'each reason must show the weight that produced it',
      );
    }
  });
}
