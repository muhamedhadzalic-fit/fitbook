import '../models/enums.dart';
import '../models/verification.dart';

/// Trainer-verification fixtures.
///
/// This queue is the desktop app's reason for existing: trainers self-register
/// from mobile into `Pending`, and an admin approves or rejects them here.
abstract final class MockVerification {
  static const queueHeading = 'Pending verification';

  /// Subtitle under the queue heading. Takes the queue's length, so the count
  /// stays the list's own rather than a second number to keep in step.
  static String queueSubtitle(int count) => '$count trainers awaiting review';

  /// Byline under an uploaded document — its size and when it arrived.
  static String documentByline(String sizeLabel, String uploadedLabel) =>
      '$sizeLabel · uploaded $uploadedLabel';

  static const checklistHeading = 'Verification checklist';
  static const documentsHeading = 'Uploaded documents';
  static const bioHeading = 'Bio submitted';
  static const viewDocumentLabel = 'View →';

  static String submittedSummary(String submittedLabel, int proposedRate) =>
      'Submitted $submittedLabel · $proposedRate KM/h proposed rate';

  /// Copy for the approve / reject confirmation dialog.
  static const cancelLabel = 'Cancel';
  static const approveConfirmLabel = 'Approve trainer';
  static const rejectConfirmLabel = 'Reject';
  static const reasonLabel = 'Reason for rejection';
  static const reasonHint =
      'e.g. Certification could not be verified against the issuing registry.';

  /// Shown below the field, not inside it — a rejection needs a reason.
  static const reasonRequired =
      'A reason is required before rejecting an application.';

  static String approveTitle(String name) => 'Approve $name?';
  static String rejectTitle(String name) => 'Reject $name\'s application?';

  static String approveBody(String name) =>
      '$name will move from Pending to Active and can start accepting '
      'bookings immediately. This is written to the audit trail.';

  static String rejectBody(String name) =>
      '$name will be told why their application was rejected and can '
      'resubmit. The reason is written to the audit trail.';

  static const actions = VerificationActions(
    approve: 'Approve trainer',
    reject: 'Reject application',
    requestInfo: 'Request more info',
    pendingBadge: 'Pending review',
  );

  static const queue = <VerificationApplication>[
    VerificationApplication(
      name: 'Lejla Hodžić',
      email: 'lejla.hodzic@fitbook.ba',
      phone: '+387 61 234 567',
      city: 'Tuzla',
      specialities: ['Cardio', 'HIIT'],
      submittedLabel: '2 hours ago',
      yearsExperience: 4,
      proposedRate: 35,
      identityHue: 280,
      bio:
          'Certified cardio and HIIT instructor with 4 years of group-class '
          'experience in Tuzla. Specializing in fat-loss programs and '
          'high-intensity interval training. Yoga Alliance RYT-200 certified.',
      checklist: [
        VerificationCheck(
          state: CheckState.ok,
          label: 'Identity document (CIPS)',
          detail: 'Verified via OCR · ID matches profile',
        ),
        VerificationCheck(
          state: CheckState.ok,
          label: 'Email verified',
          detail: 'lejla.hodzic@fitbook.ba',
        ),
        VerificationCheck(
          state: CheckState.ok,
          label: 'Phone number',
          detail: '+387 61 234 567',
        ),
        VerificationCheck(
          state: CheckState.warning,
          label: 'Certification',
          detail: 'Diploma uploaded — needs manual review',
        ),
        VerificationCheck(
          state: CheckState.ok,
          label: 'Profile photo',
          detail: 'Auto-approved',
        ),
        VerificationCheck(
          state: CheckState.pending,
          label: 'Reference check',
          detail: '2 of 2 references contacted',
        ),
      ],
      documents: [
        UploadedDocument(
          fileName: 'ID_card_front.pdf',
          sizeLabel: '1.2 MB',
          uploadedLabel: 'Apr 23',
          kind: 'PDF',
        ),
        UploadedDocument(
          fileName: 'Yoga_Alliance_RYT200.pdf',
          sizeLabel: '2.4 MB',
          uploadedLabel: 'Apr 23',
          kind: 'PDF',
        ),
        UploadedDocument(
          fileName: 'HIIT_certification.jpg',
          sizeLabel: '0.8 MB',
          uploadedLabel: 'Apr 23',
          kind: 'JPG',
        ),
        UploadedDocument(
          fileName: 'Reference_letter.docx',
          sizeLabel: '0.3 MB',
          uploadedLabel: 'Apr 24',
          kind: 'DOC',
        ),
      ],
    ),
    VerificationApplication(
      name: 'Goran Lukić',
      email: 'goran.lukic@fitbook.ba',
      phone: '+387 63 771 402',
      city: 'Mostar',
      specialities: ['Strength'],
      submittedLabel: 'Yesterday',
      yearsExperience: 7,
      proposedRate: 42,
      identityHue: 50,
      bio:
          'Strength and conditioning coach with 7 years in commercial gyms. '
          'Focus on barbell technique and progressive overload for '
          'intermediate lifters.',
      checklist: [
        VerificationCheck(
          state: CheckState.ok,
          label: 'Identity document (CIPS)',
          detail: 'Verified via OCR · ID matches profile',
        ),
        VerificationCheck(
          state: CheckState.ok,
          label: 'Email verified',
          detail: 'goran.lukic@fitbook.ba',
        ),
        VerificationCheck(
          state: CheckState.failed,
          label: 'Phone number',
          detail: 'Verification SMS not confirmed',
        ),
        VerificationCheck(
          state: CheckState.ok,
          label: 'Certification',
          detail: 'NSCA CSCS — verified against registry',
        ),
        VerificationCheck(
          state: CheckState.warning,
          label: 'Profile photo',
          detail: 'Low resolution — request a replacement',
        ),
        VerificationCheck(
          state: CheckState.pending,
          label: 'Reference check',
          detail: '1 of 2 references contacted',
        ),
      ],
      documents: [
        UploadedDocument(
          fileName: 'Licna_karta.pdf',
          sizeLabel: '0.9 MB',
          uploadedLabel: 'Apr 24',
          kind: 'PDF',
        ),
        UploadedDocument(
          fileName: 'NSCA_CSCS.pdf',
          sizeLabel: '1.6 MB',
          uploadedLabel: 'Apr 24',
          kind: 'PDF',
        ),
      ],
    ),
    VerificationApplication(
      name: 'Mirza Aldić',
      email: 'mirza.aldic@fitbook.ba',
      phone: '+387 62 118 903',
      city: 'Sarajevo',
      specialities: ['MMA', 'Boxing'],
      submittedLabel: '3 days ago',
      yearsExperience: 5,
      proposedRate: 48,
      identityHue: 5,
      bio:
          'Amateur MMA competitor turned coach. Sessions cover striking, '
          'grappling fundamentals and fight-camp conditioning.',
      checklist: [
        VerificationCheck(
          state: CheckState.ok,
          label: 'Identity document (CIPS)',
          detail: 'Verified via OCR · ID matches profile',
        ),
        VerificationCheck(
          state: CheckState.ok,
          label: 'Email verified',
          detail: 'mirza.aldic@fitbook.ba',
        ),
        VerificationCheck(
          state: CheckState.ok,
          label: 'Phone number',
          detail: '+387 62 118 903',
        ),
        VerificationCheck(
          state: CheckState.warning,
          label: 'Certification',
          detail: 'Federation licence expires in 2 months',
        ),
        VerificationCheck(
          state: CheckState.ok,
          label: 'Profile photo',
          detail: 'Auto-approved',
        ),
        VerificationCheck(
          state: CheckState.pending,
          label: 'Reference check',
          detail: '0 of 2 references contacted',
        ),
      ],
      documents: [
        UploadedDocument(
          fileName: 'ID_scan.pdf',
          sizeLabel: '1.1 MB',
          uploadedLabel: 'Apr 22',
          kind: 'PDF',
        ),
        UploadedDocument(
          fileName: 'MMA_licence_2026.pdf',
          sizeLabel: '0.6 MB',
          uploadedLabel: 'Apr 22',
          kind: 'PDF',
        ),
      ],
    ),
    VerificationApplication(
      name: 'Aida Kurtović',
      email: 'aida.kurtovic@fitbook.ba',
      phone: '+387 61 440 217',
      city: 'Zenica',
      specialities: ['Yoga'],
      submittedLabel: '5 days ago',
      yearsExperience: 3,
      proposedRate: 30,
      identityHue: 195,
      bio:
          'Hatha and vinyasa yoga teacher. Classes emphasise breathwork and '
          'accessible sequencing for beginners.',
      checklist: [
        VerificationCheck(
          state: CheckState.ok,
          label: 'Identity document (CIPS)',
          detail: 'Verified via OCR · ID matches profile',
        ),
        VerificationCheck(
          state: CheckState.ok,
          label: 'Email verified',
          detail: 'aida.kurtovic@fitbook.ba',
        ),
        VerificationCheck(
          state: CheckState.ok,
          label: 'Phone number',
          detail: '+387 61 440 217',
        ),
        VerificationCheck(
          state: CheckState.ok,
          label: 'Certification',
          detail: 'RYT-500 — verified against registry',
        ),
        VerificationCheck(
          state: CheckState.ok,
          label: 'Profile photo',
          detail: 'Auto-approved',
        ),
        VerificationCheck(
          state: CheckState.ok,
          label: 'Reference check',
          detail: '2 of 2 references confirmed',
        ),
      ],
      documents: [
        UploadedDocument(
          fileName: 'ID_card.pdf',
          sizeLabel: '1.0 MB',
          uploadedLabel: 'Apr 20',
          kind: 'PDF',
        ),
        UploadedDocument(
          fileName: 'RYT500_certificate.pdf',
          sizeLabel: '2.1 MB',
          uploadedLabel: 'Apr 20',
          kind: 'PDF',
        ),
      ],
    ),
  ];
}
