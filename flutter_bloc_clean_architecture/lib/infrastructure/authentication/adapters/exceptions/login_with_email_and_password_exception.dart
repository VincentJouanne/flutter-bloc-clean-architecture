// coverage:ignore-file
class LogInWithEmailAndPasswordException implements Exception {
  const LogInWithEmailAndPasswordException([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LogInWithEmailAndPasswordException.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordException(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordException(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordException(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordException(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordException();
    }
  }

  final String message;
}
