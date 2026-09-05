import '../models/trainer.dart';

/// Trainer fixtures for the mobile app.
///
/// Mock data only — no screen may declare a trainer inline. When the API lands,
/// this file is deleted and a repository returns the same [Trainer] type.
abstract final class MockTrainers {
  static const all = <Trainer>[
    Trainer(
      id: 't1',
      name: 'Ana Kovač',
      specialities: ['Yoga', 'Pilates'],
      rating: 4.9,
      reviewCount: 128,
      hourlyRate: 35,
      identityHue: 320,
      isOnline: true,
      city: 'Sarajevo',
      district: 'Centar',
      yearsExperience: 8,
      clientCount: '410+',
      bio:
          'Certified yoga and Pilates instructor with 8 years of studio '
          'experience. I build slow, sustainable mobility programmes and pay '
          'close attention to breathing and alignment.',
      isCertified: true,
    ),
    Trainer(
      id: 't2',
      name: 'Marko Petrić',
      specialities: ['CrossFit', 'HIIT'],
      rating: 4.8,
      reviewCount: 214,
      hourlyRate: 45,
      identityHue: 215,
      isOnline: true,
      city: 'Sarajevo',
      district: 'Marijin Dvor',
      yearsExperience: 6,
      clientCount: '340+',
      bio:
          'Certified personal trainer with 6+ years of experience in CrossFit '
          'and functional training. I focus on sustainable progress, balanced '
          'nutrition, and injury prevention.',
      isCertified: true,
    ),
    Trainer(
      id: 't3',
      name: 'Iva Milić',
      specialities: ['Strength'],
      rating: 4.7,
      reviewCount: 96,
      hourlyRate: 40,
      identityHue: 30,
      isOnline: false,
      city: 'Mostar',
      district: 'Rondo',
      yearsExperience: 5,
      clientCount: '180+',
      bio:
          'Powerlifting background, now coaching general strength. Programmes '
          'are built around the big three lifts with a strong emphasis on '
          'technique before load.',
      isCertified: true,
    ),
    Trainer(
      id: 't4',
      name: 'Damir Jurić',
      specialities: ['Boxing', 'MMA'],
      rating: 4.9,
      reviewCount: 187,
      hourlyRate: 50,
      identityHue: 5,
      isOnline: true,
      city: 'Sarajevo',
      district: 'Skenderija',
      yearsExperience: 11,
      clientCount: '520+',
      bio:
          'Former competitive boxer coaching striking and conditioning for all '
          'levels. Sessions mix pad work, footwork drills and high-intensity '
          'conditioning.',
      isCertified: true,
    ),
    Trainer(
      id: 't5',
      name: 'Lejla Hodžić',
      specialities: ['Cardio'],
      rating: 4.6,
      reviewCount: 73,
      hourlyRate: 30,
      identityHue: 280,
      isOnline: false,
      city: 'Tuzla',
      district: 'Slatina',
      yearsExperience: 4,
      clientCount: '120+',
      bio:
          'Cardio and HIIT instructor specialising in fat-loss programmes for '
          'beginners. Group-class background, now coaching one-on-one.',
      isCertified: true,
    ),
    Trainer(
      id: 't6',
      name: 'Tarik Bešić',
      specialities: ['Running'],
      rating: 4.8,
      reviewCount: 142,
      hourlyRate: 35,
      identityHue: 145,
      isOnline: true,
      city: 'Sarajevo',
      district: 'Vilsonovo šetalište',
      yearsExperience: 7,
      clientCount: '260+',
      bio:
          'Endurance coach running outdoor sessions year-round. Plans are built '
          'around heart-rate zones and progressive weekly volume.',
      isCertified: true,
    ),
  ];

  static Trainer byId(String id) => all.firstWhere((t) => t.id == id);

  /// The trainer used as the entry point of the prototype booking flow.
  static Trainer get featured => all[1];
}
