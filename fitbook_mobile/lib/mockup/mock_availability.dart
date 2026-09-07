import '../models/trainer.dart';

/// Weekly availability fixtures for the trainer detail screen.
abstract final class MockAvailability {
  static const thisWeek = WeeklyAvailability(
    monthLabel: 'May',
    days: [
      AvailabilityDay(weekday: 'Mon', dayOfMonth: 28),
      AvailabilityDay(weekday: 'Tue', dayOfMonth: 29),
      AvailabilityDay(weekday: 'Wed', dayOfMonth: 30),
      AvailabilityDay(weekday: 'Thu', dayOfMonth: 1),
      AvailabilityDay(weekday: 'Fri', dayOfMonth: 2),
      AvailabilityDay(weekday: 'Sat', dayOfMonth: 3),
      AvailabilityDay(weekday: 'Sun', dayOfMonth: 4),
    ],
    slots: [
      AvailabilitySlot(time: '08:00', isTaken: false),
      AvailabilitySlot(time: '09:00', isTaken: true),
      AvailabilitySlot(time: '10:00', isTaken: false),
      AvailabilitySlot(time: '11:00', isTaken: false),
      AvailabilitySlot(time: '14:00', isTaken: true),
      AvailabilitySlot(time: '16:00', isTaken: false),
      AvailabilitySlot(time: '17:30', isTaken: false),
      AvailabilitySlot(time: '19:00', isTaken: false),
    ],
    initialDayIndex: 4,
    initialSlot: '10:00',
  );
}
