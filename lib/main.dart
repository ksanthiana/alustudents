import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } else {
      try {
        final options = DefaultFirebaseOptions.currentPlatform;
        await Firebase.initializeApp(options: options);
      } catch (_) {
        await Firebase.initializeApp();
      }
    }

  } catch (err) {
    debugPrint('FIREBASE INITIALIZATION ERROR: $err');
  }

  runApp(const ProviderScope(child: AluInternApp()));
}
