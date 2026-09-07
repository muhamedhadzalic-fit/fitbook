import 'package:flutter/material.dart';

import 'screens/admin_app.dart';
import 'theme/fb_theme.dart';

/// Base URL of the FitBook API.
///
/// Supplied at build time — the Windows build targets localhost:
/// `flutter run -d windows --dart-define=API_BASE_URL=http://localhost:5274`.
/// Plain HTTP, never hardcoded in source.
const apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:5274',
);

void main() => runApp(const FitBookAdminApp());

/// The FitBook admin app — Flutter Desktop, Windows.
class FitBookAdminApp extends StatelessWidget {
  const FitBookAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitBook Admin',
      debugShowCheckedModeBanner: false,
      theme: FBTheme.build(),
      // Sign-in lands here once auth exists; for now the shell opens directly.
      home: const AdminApp(),
    );
  }
}
