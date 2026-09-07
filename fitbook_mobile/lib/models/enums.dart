/// Lifecycle of a booking, matching the server-side state machine
/// (`Pending -> Confirmed -> Completed`, with `Cancelled` / `Rejected`).
enum BookingStatus { pending, confirmed, completed, cancelled, rejected }

/// Severity of a notification, which drives its icon and tint.
enum NotificationTone { success, warning, info, error }

/// Who authored a chat turn.
enum ChatAuthor { user, assistant }

/// Verification state of a trainer account.
enum TrainerState { pending, active, inactive }

/// Which of the two roles the mobile app is currently presenting.
enum AppRole { client, trainer }
