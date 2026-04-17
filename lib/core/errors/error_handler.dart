import 'package:firebase_auth/firebase_auth.dart';

import 'exceptions.dart';
import 'failures.dart';

/// Converts low-level exceptions into domain [Failure]s.
class ErrorHandler {
  ErrorHandler._();

  static Failure handle(Object error) {
    if (error is FirebaseAuthException) {
      return Failure.auth(message: _firebaseAuthMessage(error.code));
    }
    if (error is ServerException) {
      return Failure.server(message: error.message, statusCode: error.statusCode);
    }
    if (error is NetworkException) {
      return Failure.network(message: error.message);
    }
    if (error is AuthException) {
      return Failure.auth(message: error.message);
    }
    if (error is CacheException) {
      return Failure.cache(message: error.message);
    }
    if (error is NotFoundException) {
      return Failure.notFound(message: error.message);
    }
    return Failure.unknown(message: error.toString());
  }

  static String _firebaseAuthMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return 'Authentication error: $code';
    }
  }
}
