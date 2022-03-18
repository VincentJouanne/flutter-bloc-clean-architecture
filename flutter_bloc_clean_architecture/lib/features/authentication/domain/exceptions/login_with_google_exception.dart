// coverage:ignore-file
class LogInWithGoogleException implements Exception {
  const LogInWithGoogleException([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LogInWithGoogleException.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleException(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleException(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleException(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleException(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleException(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleException(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleException(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleException(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleException();
    }
  }

  final String message;
}
