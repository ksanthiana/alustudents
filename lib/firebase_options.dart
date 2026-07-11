import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions have not been configured for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA0l25ANCqndPuRXOTJDgfFkTnprWRRE8c',
    authDomain: 'aluinternship.firebaseapp.com',
    projectId: 'aluinternship',
    storageBucket: 'aluinternship.firebasestorage.app',
    messagingSenderId: '802794726298',
    appId: '1:802794726298:web:2a029b1f53ae377ce85023',
    measurementId: 'G-B9VV3BEM71',
  );
}
