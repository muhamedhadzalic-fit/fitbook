import '../models/trainer_workspace.dart';

/// Trainer-side booking fixtures.
abstract final class MockTrainerWorkspace {
  static const workspace = TrainerWorkspace(
    trainerName: 'Marko Petrić',
    trainerHue: 215,
    roleLabel: 'TRAINER MODE',
    pendingNotice:
        '3 requests waiting. Respond within 24h or they\'ll auto-cancel.',
    requests: [
      BookingRequest(
        reference: '#FB-2841',
        clientName: 'Amila Đedović',
        clientHue: 280,
        dateLabel: 'Tomorrow, Apr 26',
        timeLabel: '10:00 – 11:00',
        location: 'Olympic Gym',
        amount: 45,
        durationLabel: '60 min',
        clientNote: 'Lower back recovering, keep deadlifts light',
      ),
      BookingRequest(
        reference: '#FB-2843',
        clientName: 'Haris Tabaković',
        clientHue: 50,
        dateLabel: 'Sat, Apr 27',
        timeLabel: '08:30 – 09:30',
        location: 'Studio Centar',
        amount: 45,
        durationLabel: '60 min',
        clientNote: '',
      ),
      BookingRequest(
        reference: '#FB-2848',
        clientName: 'Tea Šabić',
        clientHue: 30,
        dateLabel: 'Sun, Apr 28',
        timeLabel: '17:00 – 18:00',
        location: 'BBI Fitness',
        amount: 50,
        durationLabel: '60 min',
        clientNote: 'First session — beginner level',
      ),
    ],
    confirmed: [
      ConfirmedSession(
        reference: '#FB-2832',
        clientName: 'Edin Mehmedović',
        clientHue: 145,
        dateLabel: 'Today, Apr 25',
        timeLabel: '14:00 – 15:00',
        location: 'Olympic Gym',
        amount: 45,
      ),
      ConfirmedSession(
        reference: '#FB-2828',
        clientName: 'Selma Hadžić',
        clientHue: 320,
        dateLabel: 'Today, Apr 25',
        timeLabel: '17:00 – 18:00',
        location: 'Olympic Gym',
        amount: 50,
      ),
    ],
    confirmedFooter: 'That\'s it for today · 95 KM earned',
    historyCount: 84,
    historyPlaceholder: '84 completed sessions · Tap to view',
  );

  static const declineLabel = 'Decline';
  static const acceptLabel = 'Accept booking';
}
