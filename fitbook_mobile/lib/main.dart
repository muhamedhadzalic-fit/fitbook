import 'package:flutter/material.dart';

import 'screens/app_root.dart';
import 'theme/fb_theme.dart';

/// Base URL of the FitBook API.
///
/// Supplied at build time — the Android build targets the AVD host address:
/// `flutter run -d android --dart-define=API_BASE_URL=http://10.0.2.2:5274`.
/// Plain HTTP, never hardcoded in source.
const apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:5274',
);

void main() => runApp(const FitBookApp());

/// The FitBook mobile app — clients and trainers share it, routed by JWT role
/// through a single login form.
class FitBookApp extends StatelessWidget {
  const FitBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitBook',
      debugShowCheckedModeBanner: false,
      theme: FBTheme.build(),
      // The welcome screen, then the shell for whichever role signed in.
      // `AppRoot` holds that role in memory; it reads it off the JWT once auth
      // lands, and nothing else about the routing changes.
      home: const AppRoot(),
    );
  }
}
