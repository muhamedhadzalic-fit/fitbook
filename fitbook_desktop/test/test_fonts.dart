import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Loads the bundled Inter faces into the test font collection.
///
/// Widget tests otherwise render text with a placeholder font whose every
/// glyph is a square the width of the font size. That makes text far wider
/// than production and produces overflow errors that do not exist in the real
/// app — so any test that asserts on layout must load the real font first.
Future<void> loadInterFonts() async {
  const faces = [
    'Inter-Regular',
    'Inter-Medium',
    'Inter-SemiBold',
    'Inter-Bold',
    'Inter-ExtraBold',
  ];

  final loader = FontLoader('Inter');
  for (final face in faces) {
    final bytes = File('assets/fonts/$face.ttf').readAsBytesSync();
    loader.addFont(
      Future.value(ByteData.sublistView(Uint8List.fromList(bytes))),
    );
  }
  await loader.load();
}
