import 'enums.dart';

/// A trainer application waiting in the verification queue.
class VerificationApplication {
  const VerificationApplication({
    required this.name,
    required this.email,
    required this.phone,
    required this.city,
    required this.specialities,
    required this.submittedLabel,
    required this.yearsExperience,
    required this.proposedRate,
    required this.identityHue,
    required this.bio,
    required this.checklist,
    required this.documents,
  });

  final String name;
  final String email;
  final String phone;
  final String city;
  final List<String> specialities;
  final String submittedLabel;
  final int yearsExperience;
  final int proposedRate;
  final double identityHue;
  final String bio;
  final List<VerificationCheck> checklist;
  final List<UploadedDocument> documents;

  String get summary =>
      '${specialities.join(', ')} · $city · $yearsExperience years experience';
}

/// One item on the verification checklist.
class VerificationCheck {
  const VerificationCheck({
    required this.state,
    required this.label,
    required this.detail,
  });

  final CheckState state;
  final String label;
  final String detail;
}

/// A document the applicant uploaded.
class UploadedDocument {
  const UploadedDocument({
    required this.fileName,
    required this.sizeLabel,
    required this.uploadedLabel,
    required this.kind,
  });

  final String fileName;
  final String sizeLabel;
  final String uploadedLabel;

  /// Short badge text, e.g. "PDF".
  final String kind;
}

/// Copy for the verification screen's action buttons.
class VerificationActions {
  const VerificationActions({
    required this.approve,
    required this.reject,
    required this.requestInfo,
    required this.pendingBadge,
  });

  final String approve;
  final String reject;
  final String requestInfo;
  final String pendingBadge;
}
