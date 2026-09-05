import '../models/onboarding.dart';

/// Welcome / registration fixtures.
abstract final class MockOnboarding {
  static const welcome = WelcomeSlide(
    headline: 'Train smarter.\nBook better.',
    body:
        'Find certified trainers across Bosnia, book sessions in seconds, and '
        'let our AI build the perfect program for you.',
    slideCount: 3,
    activeIndex: 0,
    primaryCta: 'Create account',
    secondaryCta: 'I already have an account',
    legalNote: 'By continuing you agree to our Terms & Privacy Policy',
  );

  static const memberRegistration = MemberRegistration(
    title: 'Create account',
    stepLabel: 'Step 1 of 3 · Personal info',
    selectedRoleId: 'client',
    roles: [
      RoleChoice(
        id: 'client',
        title: 'I\'m a member',
        subtitle: 'Book trainers',
      ),
      RoleChoice(
        id: 'trainer',
        title: 'I\'m a trainer',
        subtitle: 'Offer sessions',
      ),
    ],
    fields: [
      FormFieldSample(label: 'Full name', value: 'Amila Đedović'),
      FormFieldSample(label: 'Email', value: 'amila.djedovic@email.ba'),
      FormFieldSample(label: 'Password', value: '••••••••••', suffix: 'show'),
      FormFieldSample(label: 'City', value: 'Sarajevo', isDropdown: true),
    ],
    consentLabel: 'I agree to the Terms and Privacy Policy',
    submitLabel: 'Continue',
    signInPrompt: 'Already a member? Sign in',
  );

  static const trainerRegistration = TrainerRegistration(
    flowLabel: 'Become a trainer · Step 2 of 4',
    stepTitle: 'Specializations & Rate',
    stepCount: 4,
    currentStep: 2,
    photoOwnerName: 'Lejla Hodžić',
    photoHue: 280,
    photoTitle: 'Profile photo',
    photoHint: 'Members will see this on your card. Use a clear, recent photo.',
    specialityPrompt: 'Pick your specializations (up to 4)',
    specialities: [
      SpecialityChoice(label: 'Yoga', isSelected: true),
      SpecialityChoice(label: 'Pilates', isSelected: false),
      SpecialityChoice(label: 'CrossFit', isSelected: false),
      SpecialityChoice(label: 'HIIT', isSelected: true),
      SpecialityChoice(label: 'Strength', isSelected: false),
      SpecialityChoice(label: 'Boxing', isSelected: false),
      SpecialityChoice(label: 'Cardio', isSelected: true),
      SpecialityChoice(label: 'Running', isSelected: false),
      SpecialityChoice(label: 'MMA', isSelected: false),
      SpecialityChoice(label: 'Functional', isSelected: false),
    ],
    fields: [
      FormFieldSample(
        label: 'Years of experience',
        value: '4 years',
        isDropdown: true,
      ),
      FormFieldSample(label: 'Rate per hour (KM)', value: '35'),
    ],
    certificationLabel: 'Upload certification',
    certification: UploadedDocument(
      fileName: 'Yoga_RYT200_certificate.pdf',
      detail: '2.4 MB · just uploaded',
      kind: 'PDF',
    ),
    verificationNotice:
        'Verification needed. An admin will review your profile within 24h '
        'before you can accept bookings.',
  );
}
