import '../models/enums.dart';
import '../models/trainer.dart';

/// Trainer-management fixtures.
abstract final class MockTrainers {
  static const rows = <TrainerRow>[
    TrainerRow(
      id: 'tr-1',
      name: 'Ana Kovač',
      email: 'ana.kovac@fitbook.ba',
      specialities: ['Yoga', 'Pilates'],
      city: 'Sarajevo',
      hourlyRate: 35,
      identityHue: 320,
      activeBookings: 12,
      status: TrainerStatus.active,
    ),
    TrainerRow(
      id: 'tr-2',
      name: 'Marko Petrić',
      email: 'marko.petric@fitbook.ba',
      specialities: ['CrossFit', 'HIIT'],
      city: 'Sarajevo',
      hourlyRate: 45,
      identityHue: 215,
      activeBookings: 18,
      status: TrainerStatus.active,
    ),
    TrainerRow(
      id: 'tr-3',
      name: 'Iva Milić',
      email: 'iva.milic@fitbook.ba',
      specialities: ['Strength'],
      city: 'Mostar',
      hourlyRate: 40,
      identityHue: 30,
      activeBookings: 0,
      status: TrainerStatus.active,
    ),
    TrainerRow(
      id: 'tr-4',
      name: 'Damir Jurić',
      email: 'damir.juric@fitbook.ba',
      specialities: ['Boxing', 'MMA'],
      city: 'Sarajevo',
      hourlyRate: 50,
      identityHue: 5,
      activeBookings: 9,
      status: TrainerStatus.active,
    ),
    TrainerRow(
      id: 'tr-5',
      name: 'Lejla Hodžić',
      email: 'lejla.hodzic@fitbook.ba',
      specialities: ['Cardio'],
      city: 'Tuzla',
      hourlyRate: 30,
      identityHue: 280,
      activeBookings: 0,
      status: TrainerStatus.pending,
    ),
    TrainerRow(
      id: 'tr-6',
      name: 'Tarik Bešić',
      email: 'tarik.besic@fitbook.ba',
      specialities: ['Running'],
      city: 'Sarajevo',
      hourlyRate: 35,
      identityHue: 145,
      activeBookings: 6,
      status: TrainerStatus.active,
    ),
    TrainerRow(
      id: 'tr-7',
      name: 'Nermina Smajić',
      email: 'nermina.smajic@fitbook.ba',
      specialities: ['Yoga'],
      city: 'Banja Luka',
      hourlyRate: 32,
      identityHue: 195,
      activeBookings: 3,
      status: TrainerStatus.active,
    ),
    TrainerRow(
      id: 'tr-8',
      name: 'Goran Lukić',
      email: 'goran.lukic@fitbook.ba',
      specialities: ['Strength', 'CrossFit'],
      city: 'Mostar',
      hourlyRate: 42,
      identityHue: 50,
      activeBookings: 0,
      status: TrainerStatus.inactive,
    ),
  ];

  static const searchHint = 'Search by name…';

  static String rosterSummary(int trainerCount, int cityCount) =>
      '$trainerCount trainers · $cityCount cities';
  static const addLabel = 'Add new trainer';

  /// Dropdown options, sourced from reference tables in the real app.
  static const specialityOptions = <String>[
    'All specializations',
    'Yoga',
    'Pilates',
    'CrossFit',
    'HIIT',
    'Strength',
    'Boxing',
    'MMA',
    'Cardio',
    'Running',
  ];
  static const cityOptions = <String>[
    'All cities',
    'Sarajevo',
    'Mostar',
    'Tuzla',
    'Banja Luka',
  ];
  static const statusOptions = <String>[
    'All statuses',
    'Active',
    'Pending',
    'Inactive',
  ];

  static const createForm = CreateTrainerForm(
    title: 'Add new trainer',
    subtitle: 'Fill in the profile details and upload a photo.',
    photoTitle: 'Profile photo',
    photoHint:
        'Square JPG or PNG, at least 400×400px. This photo will appear on '
        'the mobile app and trainer cards.',
    photoEmptyLabel: 'No photo',
    uploadLabel: 'Upload photo',
    libraryLabel: 'Choose from library',
    requiredNote: 'Required fields',
    cancelLabel: 'Cancel',
    submitLabel: 'Create trainer',
    fields: [
      FormFieldSpec(
        label: 'Full name',
        value: '',
        placeholder: 'e.g. Ana Kovač',
        isRequired: true,
      ),
      FormFieldSpec(
        label: 'Email',
        value: '',
        placeholder: 'ime.prezime@fitbook.ba',
        isRequired: true,
      ),
      FormFieldSpec(label: 'Phone', value: '', placeholder: '+387 33 …'),
      FormFieldSpec(
        label: 'City',
        value: 'Sarajevo',
        isRequired: true,
        isDropdown: true,
      ),
      FormFieldSpec(
        label: 'Specializations',
        value: 'Yoga, Pilates',
        isRequired: true,
        isDropdown: true,
        isChips: true,
        spansRow: true,
      ),
      FormFieldSpec(
        label: 'Price per hour (KM)',
        value: '35',
        placeholder: '35',
        isRequired: true,
        suffix: 'KM/h',
      ),
      FormFieldSpec(label: 'Years of experience', value: '6', placeholder: '0'),
      FormFieldSpec(label: 'Status', value: 'Active', isDropdown: true),
      FormFieldSpec(
        label: 'Short bio',
        value: '',
        placeholder:
            'A short paragraph about training style, certifications and '
            'approach…',
        isTextarea: true,
        spansRow: true,
      ),
    ],
  );

  static const emptyMessage = 'No trainers match these filters';
  static const editTooltip = 'Edit trainer';
  static const deleteTooltip = 'Delete trainer';
  static const rateSuffix = 'KM';

  /// Why the delete action is unavailable for a given trainer.
  static String deleteDisabledReason(int activeBookings) =>
      'Has $activeBookings active reservations';

  static String pageSummary(int shown, int total) =>
      'Showing 1–$shown of $total trainers';

  /// Copy for the delete confirmation, in both its allowed and blocked forms.
  static const deleteBlockedTitle = 'Cannot delete this trainer';
  static const deleteBlockedAcknowledge = 'Got it';
  static const deleteBlockedAlternative = 'Set inactive instead';
  static const deleteBlockedViewBookings = 'View bookings →';
  static const deleteConfirmLabel = 'Delete trainer';
  static const deleteCancelLabel = 'Cancel';
  static const deleteWarning =
      'This will permanently remove the trainer and all historical session '
      'data. This action cannot be undone.';

  static String deleteConfirmTitle(String name) => 'Delete $name?';

  /// Explains the constraint that blocks a hard delete.
  static String deleteBlockedBody(String name, int activeBookings) =>
      '$name has $activeBookings active reservations and cannot be deleted. '
      'Cancel or reassign those bookings first, or set the trainer to '
      'inactive to hide them from new bookings.';

  static String deleteBlockedCount(int activeBookings) =>
      '$activeBookings upcoming bookings';
}
