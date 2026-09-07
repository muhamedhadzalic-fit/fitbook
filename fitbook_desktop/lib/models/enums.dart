/// Lifecycle of a booking, matching the server-side state machine
/// (`Pending -> Confirmed -> Completed`, with `Cancelled` / `Rejected`).
///
/// Admins observe these transitions; trainers make them.
enum BookingStatus { pending, confirmed, completed, cancelled, rejected }

/// Verification state of a trainer account.
enum TrainerStatus { active, pending, inactive }

/// Subscription state of a member account.
enum MemberStatus { active, expired, suspended }

/// Outcome of one item on the verification checklist.
enum CheckState { ok, warning, pending, failed }

/// Whether a generated report is downloadable yet.
enum ReportState { ready, generating }
