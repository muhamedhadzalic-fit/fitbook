import 'package:flutter/material.dart';

import 'client_shell.dart';
import 'onboarding_screen.dart';
import 'register_screen.dart';
import 'trainer_register_screen.dart';
import 'trainer_shell.dart';

/// Which app the signed-in user gets.
///
/// This stands in for the `role` claim on the JWT. One login serves both roles;
/// the role decides the shell, never a separate login screen.
enum SessionRole { client, trainer }

/// The app's root: no session means the welcome/registration flow, a session
/// means that role's shell.
class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  /// Null until the user signs in. Replaced by the decoded JWT once auth lands.
  SessionRole? _role;

  void _signIn(SessionRole role) => setState(() => _role = role);
  void _signOut() => setState(() => _role = null);

  @override
  Widget build(BuildContext context) {
    return switch (_role) {
      // Swapping the whole subtree discards the auth flow's nested navigator,
      // so signing in never leaves the welcome screen on a back stack.
      null => _AuthFlow(onSignedIn: _signIn),
      SessionRole.client => ClientShell(onSignOut: _signOut),
      SessionRole.trainer => TrainerShell(onSignOut: _signOut),
    };
  }
}

/// Welcome → registration, in its own navigator so Back behaves normally.
///
/// There is no login screen in the design: "I already have an account" signs
/// straight in as a client, which is the honest mock stand-in until a real form
/// posts credentials and gets a token back.
class _AuthFlow extends StatelessWidget {
  const _AuthFlow({required this.onSignedIn});

  final ValueChanged<SessionRole> onSignedIn;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) => MaterialPageRoute<void>(
        settings: settings,
        builder: (context) => OnboardingScreen(
          onCreateAccount: () => _pushRegister(context),
          onSignIn: () => onSignedIn(SessionRole.client),
        ),
      ),
    );
  }

  void _pushRegister(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => RegisterScreen(
          onBack: () => Navigator.of(context).pop(),
          // The role chooser on the form decides where registration goes: a
          // member is done, a trainer continues into the trainer application.
          onContinue: (roleId) => roleId == 'trainer'
              ? _pushTrainerRegister(context)
              : onSignedIn(SessionRole.client),
        ),
      ),
    );
  }

  void _pushTrainerRegister(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => TrainerRegisterScreen(
          onBack: () => Navigator.of(context).pop(),
          // A real submission lands the trainer in `Pending` until an admin
          // verifies them from the desktop app; they can still see their own
          // workspace while they wait.
          onContinue: () => onSignedIn(SessionRole.trainer),
        ),
      ),
    );
  }
}
