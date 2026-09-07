/// The welcome screen's marketing copy and pager state.
class WelcomeSlide {
  const WelcomeSlide({
    required this.headline,
    required this.body,
    required this.slideCount,
    required this.activeIndex,
    required this.primaryCta,
    required this.secondaryCta,
    required this.legalNote,
  });

  final String headline;
  final String body;
  final int slideCount;
  final int activeIndex;
  final String primaryCta;
  final String secondaryCta;
  final String legalNote;
}

/// One of the two account kinds offered at registration.
class RoleChoice {
  const RoleChoice({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  final String id;
  final String title;
  final String subtitle;
}

/// A prefilled form field in the registration mockups.
class FormFieldSample {
  const FormFieldSample({
    required this.label,
    required this.value,
    this.suffix,
    this.isDropdown = false,
  });

  final String label;
  final String value;
  final String? suffix;
  final bool isDropdown;
}

/// The member registration form.
class MemberRegistration {
  const MemberRegistration({
    required this.title,
    required this.stepLabel,
    required this.roles,
    required this.selectedRoleId,
    required this.fields,
    required this.consentLabel,
    required this.submitLabel,
    required this.signInPrompt,
  });

  final String title;
  final String stepLabel;
  final List<RoleChoice> roles;
  final String selectedRoleId;
  final List<FormFieldSample> fields;
  final String consentLabel;
  final String submitLabel;
  final String signInPrompt;
}

/// A selectable speciality chip in trainer registration.
class SpecialityChoice {
  const SpecialityChoice({required this.label, required this.isSelected});

  final String label;
  final bool isSelected;
}

/// An uploaded certification document.
class UploadedDocument {
  const UploadedDocument({
    required this.fileName,
    required this.detail,
    required this.kind,
  });

  final String fileName;
  final String detail;

  /// Short badge text, e.g. "PDF".
  final String kind;
}

/// The trainer registration step that collects specialities and rate.
class TrainerRegistration {
  const TrainerRegistration({
    required this.flowLabel,
    required this.stepTitle,
    required this.stepCount,
    required this.currentStep,
    required this.photoOwnerName,
    required this.photoHue,
    required this.photoTitle,
    required this.photoHint,
    required this.specialityPrompt,
    required this.specialities,
    required this.fields,
    required this.certificationLabel,
    required this.certification,
    required this.verificationNotice,
  });

  final String flowLabel;
  final String stepTitle;
  final int stepCount;
  final int currentStep;
  final String photoOwnerName;
  final double photoHue;
  final String photoTitle;
  final String photoHint;
  final String specialityPrompt;
  final List<SpecialityChoice> specialities;
  final List<FormFieldSample> fields;
  final String certificationLabel;
  final UploadedDocument certification;

  /// Explains that an admin must verify the account before it can take
  /// bookings — the `Pending` state.
  final String verificationNotice;
}
