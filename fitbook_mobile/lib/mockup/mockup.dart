/// The mobile app's mock data layer.
///
/// Every literal the UI displays — trainer names, prices, notification copy,
/// recommendation weights, form placeholders — lives under `lib/mockup/`.
/// Screens and widgets never declare sample data inline; they read it from
/// [Mockup] or from one of the `Mock*` fixtures re-exported here.
///
/// This directory is the seam where the real backend arrives. Once the API is
/// wired up, the repositories return the same model types from
/// `lib/models/` and `lib/mockup/` is deleted wholesale — no screen changes.
library;

import '../models/chat_message.dart';
import '../models/home_feed.dart';
import '../models/membership.dart';
import '../models/notification_item.dart';
import '../models/onboarding.dart';
import '../models/recommendation.dart';
import '../models/report.dart';
import '../models/reservation.dart';
import '../models/trainer.dart';
import '../models/trainer_workspace.dart';
import '../models/user_profile.dart';

import 'mock_availability.dart';
import 'mock_chat.dart';
import 'mock_home.dart';
import 'mock_membership.dart';
import 'mock_notifications.dart';
import 'mock_onboarding.dart';
import 'mock_profile.dart';
import 'mock_recommendations.dart';
import 'mock_reservations.dart';
import 'mock_trainer_report.dart';
import 'mock_trainer_workspace.dart';
import 'mock_trainers.dart';

export '../models/chat_message.dart';
export '../models/enums.dart';
export '../models/home_feed.dart';
export '../models/membership.dart';
export '../models/notification_item.dart';
export '../models/onboarding.dart';
export '../models/recommendation.dart';
export '../models/report.dart';
export '../models/reservation.dart';
export '../models/trainer.dart';
export '../models/trainer_workspace.dart';
export '../models/user_profile.dart';

export 'mock_availability.dart';
export 'mock_chat.dart';
export 'mock_chrome.dart';
export 'mock_home.dart';
export 'mock_membership.dart';
export 'mock_notifications.dart';
export 'mock_onboarding.dart';
export 'mock_profile.dart';
export 'mock_recommendations.dart';
export 'mock_reservations.dart';
export 'mock_session.dart';
export 'mock_trainer_report.dart';
export 'mock_trainer_workspace.dart';
export 'mock_trainers.dart';

/// Single entry point onto the mock fixtures.
///
/// Screens depend on this facade rather than on individual fixture files, so
/// swapping a mock for a repository call is a one-line change per getter.
abstract final class Mockup {
  static HomeFeed get home => MockHome.feed;
  static List<NavDestination> get navDestinations => MockHome.navDestinations;

  static List<Trainer> get trainers => MockTrainers.all;
  static Trainer get featuredTrainer => MockTrainers.featured;
  static Trainer trainer(String id) => MockTrainers.byId(id);

  static WeeklyAvailability get availability => MockAvailability.thisWeek;

  static BookingDraft get bookingDraft => MockReservations.draft;
  static ReservationHistory get reservationHistory => MockReservations.history;

  static NotificationFeed get notifications => MockNotifications.feed;

  static ChatThread get chat => MockChat.thread;

  static RecommendationFeed get recommendations => MockRecommendations.feed;

  static MembershipOffer get membership => MockMembership.offer;

  static UserProfile get profile => MockProfile.user;

  static WelcomeSlide get welcome => MockOnboarding.welcome;
  static MemberRegistration get memberRegistration =>
      MockOnboarding.memberRegistration;
  static TrainerRegistration get trainerRegistration =>
      MockOnboarding.trainerRegistration;

  static TrainerWorkspace get trainerWorkspace =>
      MockTrainerWorkspace.workspace;
  static TrainerReportForm get trainerReport => MockTrainerReport.form;
}
