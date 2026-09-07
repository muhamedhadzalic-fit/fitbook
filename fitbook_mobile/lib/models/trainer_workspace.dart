/// A booking request awaiting the trainer's decision.
class BookingRequest {
  const BookingRequest({
    required this.reference,
    required this.clientName,
    required this.clientHue,
    required this.dateLabel,
    required this.timeLabel,
    required this.location,
    required this.amount,
    required this.durationLabel,
    required this.clientNote,
  });

  final String reference;
  final String clientName;
  final double clientHue;
  final String dateLabel;
  final String timeLabel;
  final String location;
  final int amount;
  final String durationLabel;

  /// Free-text note from the client; empty when none was left.
  final String clientNote;

  bool get hasNote => clientNote.isNotEmpty;
}

/// A booking the trainer has already accepted.
class ConfirmedSession {
  const ConfirmedSession({
    required this.reference,
    required this.clientName,
    required this.clientHue,
    required this.dateLabel,
    required this.timeLabel,
    required this.location,
    required this.amount,
  });

  final String reference;
  final String clientName;
  final double clientHue;
  final String dateLabel;
  final String timeLabel;
  final String location;
  final int amount;
}

/// A tab in the trainer's bookings screen.
class WorkspaceTab {
  const WorkspaceTab({
    required this.id,
    required this.label,
    required this.count,
  });

  final String id;
  final String label;
  final int count;
}

/// The trainer's booking workspace.
class TrainerWorkspace {
  const TrainerWorkspace({
    required this.trainerName,
    required this.trainerHue,
    required this.roleLabel,
    required this.pendingNotice,
    required this.requests,
    required this.confirmed,
    required this.confirmedFooter,
    required this.historyCount,
    required this.historyPlaceholder,
  });

  final String trainerName;
  final double trainerHue;
  final String roleLabel;
  final String pendingNotice;
  final List<BookingRequest> requests;
  final List<ConfirmedSession> confirmed;
  final String confirmedFooter;
  final int historyCount;
  final String historyPlaceholder;

  List<WorkspaceTab> get tabs => [
    WorkspaceTab(id: 'pending', label: 'Pending', count: requests.length),
    WorkspaceTab(id: 'upcoming', label: 'Upcoming', count: confirmed.length),
    WorkspaceTab(id: 'history', label: 'History', count: historyCount),
  ];
}
