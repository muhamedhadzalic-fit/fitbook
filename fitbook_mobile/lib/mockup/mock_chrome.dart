/// Screen titles, field labels and action labels.
///
/// These are the app's own vocabulary rather than sample records, but they live
/// here with the rest of the copy so no screen file carries display text. That
/// keeps one rule instead of two: if it is rendered, it comes from
/// `lib/mockup/`.
abstract final class MockChrome {
  // ── Trainer detail ────────────────────────────────────────────────────────
  static const aboutHeading = 'About';
  static const availabilityHeading = 'Availability this week';
  static const perSessionLabel = 'per session';
  static const certifiedTag = 'Certified';
  static const clientsStatLabel = 'Clients';
  static const experienceStatLabel = 'Experience';
  static const reserveLabel = 'Reserve Training';

  static String reviewsStatLabel(int count) => '$count reviews';
  static String yearsValue(int years) => '$years yrs';

  // ── Booking confirmation ──────────────────────────────────────────────────
  static const bookingTitle = 'Confirm booking';
  static const trainerEyebrow = 'YOUR TRAINER';
  static const dateLabel = 'Date';
  static const timeLabel = 'Time';
  static const locationLabel = 'Location';
  static const spotsLabel = 'Spots available';
  static const priceLabel = 'Session price';
  static const notesLabel = 'Notes for your trainer (optional)';
  static const cancelLabel = 'Cancel';
  static const submitBookingLabel = 'Confirm Reservation';

  static const confirmDialogTitle = 'Confirm reservation?';
  static const confirmDialogLeadIn = 'You\'re booking a session with ';
  static const confirmDialogJoiner = ' on ';
  static const confirmDialogDecline = 'Not yet';
  static const confirmDialogAccept = 'Yes, book it';

  static String confirmDialogWindow(String window) =>
      '. The trainer has $window to confirm.';

  // ── Reservation history ───────────────────────────────────────────────────
  static const reservationsTitle = 'My reservations';
  static const justCreatedTag = 'JUST CREATED';

  static String coveredByLabel(String membership) => 'Covered by $membership';

  /// Actions offered per booking status. Order is display order; the first
  /// entry of a `pending` set is the destructive one.
  static const pendingActions = ['Cancel', 'Reschedule', 'Details'];
  static const confirmedActions = ['Reschedule', 'Details'];
  static const completedActions = ['Rate session', 'Book again'];

  // ── Notifications ─────────────────────────────────────────────────────────
  static const notificationsTitle = 'Notifications';

  static String unreadCount(int count) => '$count unread';

  // ── Profile ───────────────────────────────────────────────────────────────
  static const profileTitle = 'Profile';

  // ── Membership ────────────────────────────────────────────────────────────
  static const membershipTitle = 'Membership';
  static const perMonthSuffix = 'KM/mo';
  static const mostPopularTag = 'MOST POPULAR';

  // ── Recommendations ───────────────────────────────────────────────────────
  static const recommendationsTitle = 'For you';
  static const viewProfileLabel = 'View profile';
  static const bookSessionLabel = 'Book session';
  static const rankBadge = '#1 PICK';
  static const matchScoreLabel = 'MATCH SCORE';
  static const matchScoreDenominator = '/100';

  // ── Assistant ─────────────────────────────────────────────────────────────
  static const whyPrefix = 'Why: ';

  // ── Trainer workspace ─────────────────────────────────────────────────────
  static const trainerBookingsTitle = 'My bookings';
  static const pendingTag = 'PENDING';

  static String durationSummary(int amount, String duration) =>
      '$amount KM · $duration';

  // ── Trainer report ────────────────────────────────────────────────────────
  static const reportTitle = 'Generate report';
  static const fromLabel = 'From';
  static const toLabel = 'To';

  // ── Home feed ─────────────────────────────────────────────────────────────
  static const onlineTag = 'Online';
  static const heroPhotoCaption = 'trainer hero photo';
  static const noTrainersTitle = 'No trainers match this search';
  static const noTrainersBody =
      'Try a different speciality or clear the search field.';

  // ── Shared formatting ─────────────────────────────────────────────────────
  static const currency = 'KM';
  static const hourlyRateSuffix = 'KM/h';
  static const hourlyRateShortSuffix = 'KM/h';
  static const seeAllLabel = 'See all';
  static const backLabel = 'Back';
  static const continueLabel = 'Continue';

  static String amountLabel(int amount) => '$amount $currency';
  static String hourlyRate(int amount) => '$amount $hourlyRateSuffix';
  static String dateAndTime(String date, String time) => '$date · $time';
  static String quoted(String text) => '“$text”';
}
