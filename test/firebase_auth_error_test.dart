import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_alu_intern/src/services/auth_error_messages.dart';

void main() {
  group('auth error messaging', () {
    test('maps configuration-not-found to a helpful setup message', () {
      final error = FirebaseAuthException(
        code: 'configuration-not-found',
        message: 'Error',
      );

      final message = formatAuthErrorMessage(error);

      expect(message, contains('Firebase Authentication is not configured'));
      expect(message, contains('Enable Email/Password sign-in'));
    });
  });
}
