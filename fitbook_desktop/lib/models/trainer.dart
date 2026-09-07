import 'enums.dart';

/// A trainer row in the admin table.
class TrainerRow {
  const TrainerRow({
    required this.id,
    required this.name,
    required this.email,
    required this.specialities,
    required this.city,
    required this.hourlyRate,
    required this.identityHue,
    required this.activeBookings,
    required this.status,
  });

  final String id;
  final String name;
  final String email;
  final List<String> specialities;
  final String city;
  final int hourlyRate;
  final double identityHue;

  /// Upcoming bookings. A trainer with any is never hard-deleted — the delete
  /// action is disabled and the dialog explains why.
  final int activeBookings;

  final TrainerStatus status;

  bool get canDelete => activeBookings == 0;
}

/// A field in the create/edit trainer form.
class FormFieldSpec {
  const FormFieldSpec({
    required this.label,
    required this.value,
    this.placeholder = '',
    this.isRequired = false,
    this.isDropdown = false,
    this.isTextarea = false,
    this.isChips = false,
    this.suffix,
    this.spansRow = false,
  });

  final String label;
  final String value;
  final String placeholder;
  final bool isRequired;
  final bool isDropdown;
  final bool isTextarea;

  /// Renders the comma-separated [value] as removable chips.
  final bool isChips;

  final String? suffix;

  /// Occupies both columns of the two-column form grid.
  final bool spansRow;
}

/// The create-trainer modal's copy and fields.
class CreateTrainerForm {
  const CreateTrainerForm({
    required this.title,
    required this.subtitle,
    required this.photoTitle,
    required this.photoHint,
    required this.photoEmptyLabel,
    required this.uploadLabel,
    required this.libraryLabel,
    required this.fields,
    required this.requiredNote,
    required this.cancelLabel,
    required this.submitLabel,
  });

  final String title;
  final String subtitle;
  final String photoTitle;
  final String photoHint;
  final String photoEmptyLabel;
  final String uploadLabel;
  final String libraryLabel;
  final List<FormFieldSpec> fields;
  final String requiredNote;
  final String cancelLabel;
  final String submitLabel;
}
