import 'package:firebase_auth/firebase_auth.dart';

String formatAuthErrorMessage(FirebaseAuthException err) {
  switch (err.code) {
    case 'wrong-password':
      return 'Wrong password. Please try again.';
    case 'user-not-found':
      return 'No account found. Please sign up first.';
    case 'invalid-email':
      return 'Invalid email format. Use your ALU email.';
    case 'configuration-not-found':
      return 'Firebase Authentication is not configured correctly for this app. Enable Email/Password sign-in in Firebase Console and verify the web config values.';
    default:
      return err.message ?? 'Unable to sign in. Please check your credentials.';
  }
}
