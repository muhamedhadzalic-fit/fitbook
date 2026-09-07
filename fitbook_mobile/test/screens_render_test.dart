import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fitbook_mobile/mockup/mockup.dart';
import 'package:fitbook_mobile/screens/app_root.dart';
import 'package:fitbook_mobile/screens/booking_screen.dart';
import 'package:fitbook_mobile/screens/chat_screen.dart';
import 'package:fitbook_mobile/screens/client_shell.dart';
import 'package:fitbook_mobile/screens/home_screen.dart';
import 'package:fitbook_mobile/screens/membership_screen.dart';
import 'package:fitbook_mobile/screens/notifications_screen.dart';
import 'package:fitbook_mobile/screens/onboarding_screen.dart';
import 'package:fitbook_mobile/screens/profile_screen.dart';
import 'package:fitbook_mobile/screens/recommendations_screen.dart';
import 'package:fitbook_mobile/screens/register_screen.dart';
import 'package:fitbook_mobile/screens/reservation_history_screen.dart';
import 'package:fitbook_mobile/screens/trainer_bookings_screen.dart';
import 'package:fitbook_mobile/screens/trainer_detail_screen.dart';
import 'package:fitbook_mobile/screens/trainer_register_screen.dart';
import 'package:fitbook_mobile/screens/trainer_report_screen.dart';
import 'package:fitbook_mobile/screens/trainer_shell.dart';
import 'package:fitbook_mobile/theme/fb_theme.dart';

import 'test_fonts.dart';

/// A typical Android phone viewport — the target the design was drawn for.
const _phone = Size(412, 915);

/// Every screen, keyed by name so a failure says which one broke.
Map<String, Widget> _screens() => {
  'app root': const AppRoot(),
  'client shell': ClientShell(onSignOut: () {}),
  'trainer shell': TrainerShell(onSignOut: () {}),
  'onboarding': const OnboardingScreen(),
  'register': const RegisterScreen(),
  'trainer register': const TrainerRegisterScreen(),
  'home': const HomeScreen(),
  'trainer detail': TrainerDetailScreen(trainer: Mockup.featuredTrainer),
  'booking': BookingScreen(trainer: Mockup.featuredTrainer),
  'reservation history': const ReservationHistoryScreen(highlightNewest: true),
  'membership': const MembershipScreen(),
  'profile': const ProfileScreen(),
  'notifications': const NotificationsScreen(),
  'chat': const ChatScreen(),
  'recommendations': const RecommendationsScreen(),
  'trainer bookings': const TrainerBookingsScreen(),
  'trainer report': const TrainerReportScreen(),
};

void main() {
  setUpAll(loadInterFonts);

  group('renders without layout errors at phone size', () {
    for (final entry in _screens().entries) {
      testWidgets(entry.key, (tester) async {
        tester.view
          ..physicalSize = _phone
          ..devicePixelRatio = 1.0;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(
          MaterialApp(theme: FBTheme.build(), home: entry.value),
        );
        await tester.pumpAndSettle();

        // pumpAndSettle rethrows any layout overflow as a test failure, so
        // reaching here means the screen laid out cleanly.
        expect(tester.takeException(), isNull);
      });
    }
  });
}
