/// A trainer as the mobile app displays them.
class Trainer {
  const Trainer({
    required this.id,
    required this.name,
    required this.specialities,
    required this.rating,
    required this.reviewCount,
    required this.hourlyRate,
    required this.identityHue,
    required this.isOnline,
    required this.city,
    required this.district,
    required this.yearsExperience,
    required this.clientCount,
    required this.bio,
    required this.isCertified,
  });

  final String id;
  final String name;
  final List<String> specialities;
  final double rating;
  final int reviewCount;

  /// Price per session in KM. The server owns the authoritative price; this is
  /// display-only.
  final int hourlyRate;

  /// OKLCH hue that generates this trainer's avatar and photo gradient, so the
  /// same person reads as the same colour on every screen.
  final double identityHue;

  final bool isOnline;
  final String city;
  final String district;
  final int yearsExperience;
  final String clientCount;
  final String bio;
  final bool isCertified;

  String get location => '$city · $district';
}

/// One selectable day in a trainer's weekly availability strip.
class AvailabilityDay {
  const AvailabilityDay({required this.weekday, required this.dayOfMonth});

  final String weekday;
  final int dayOfMonth;
}

/// One bookable time slot.
class AvailabilitySlot {
  const AvailabilitySlot({required this.time, required this.isTaken});

  final String time;
  final bool isTaken;
}

/// A trainer's availability for the week being shown.
class WeeklyAvailability {
  const WeeklyAvailability({
    required this.monthLabel,
    required this.days,
    required this.slots,
    required this.initialDayIndex,
    required this.initialSlot,
  });

  final String monthLabel;
  final List<AvailabilityDay> days;
  final List<AvailabilitySlot> slots;
  final int initialDayIndex;
  final String initialSlot;
}
