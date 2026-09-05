/// The admin app's mock data layer.
///
/// Every literal the UI displays — member names, KPI figures, audit-trail
/// entries, dropdown options, form placeholders — lives under `lib/mockup/`.
/// Screens and widgets never declare sample data inline; they read it from
/// [Mockup] or from one of the `Mock*` fixtures re-exported here.
///
/// This directory is the seam where the real backend arrives. Once the API is
/// wired up, repositories return the same model types from `lib/models/` and
/// `lib/mockup/` is deleted wholesale — no screen changes.
library;

import '../models/dashboard.dart';
import '../models/member.dart';
import '../models/nav.dart';
import '../models/report.dart';
import '../models/reservation.dart';
import '../models/trainer.dart';
import '../models/verification.dart';

import 'mock_dashboard.dart';
import 'mock_members.dart';
import 'mock_nav.dart';
import 'mock_reports.dart';
import 'mock_reservation_detail.dart';
import 'mock_reservations.dart';
import 'mock_trainers.dart';
import 'mock_verification.dart';

export '../models/dashboard.dart';
export '../models/enums.dart';
export '../models/member.dart';
export '../models/nav.dart';
export '../models/report.dart';
export '../models/reservation.dart';
export '../models/trainer.dart';
export '../models/verification.dart';

export 'mock_dashboard.dart';
export 'mock_members.dart';
export 'mock_nav.dart';
export 'mock_reports.dart';
export 'mock_reservation_detail.dart';
export 'mock_reservations.dart';
export 'mock_trainers.dart';
export 'mock_verification.dart';

/// Single entry point onto the mock fixtures.
abstract final class Mockup {
  static List<NavGroup> get navGroups => MockNav.groups;
  static AdminIdentity get admin => MockNav.admin;
  static AdminBranding get branding => MockNav.branding;

  static AdminDashboard get dashboard => MockDashboard.dashboard;

  static List<ReservationRow> get recentReservations => MockReservations.recent;
  static List<ReservationRow> get reservations => MockReservations.rows;
  static List<MiniKpi> get reservationKpis => MockReservations.kpis;
  static List<StatusTab> get reservationTabs => MockReservations.tabs;

  static ReservationDetail get reservationDetail =>
      MockReservationDetail.detail;

  static List<TrainerRow> get trainers => MockTrainers.rows;
  static CreateTrainerForm get createTrainerForm => MockTrainers.createForm;

  static List<MemberRow> get members => MockMembers.rows;
  static List<MiniKpi> get memberKpis => MockMembers.kpis;

  static List<VerificationApplication> get verificationQueue =>
      MockVerification.queue;

  static ReportsWorkspace get reports => MockReports.workspace;
}
