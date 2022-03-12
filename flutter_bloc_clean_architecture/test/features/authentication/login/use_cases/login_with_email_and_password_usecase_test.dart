import 'package:flutter_clean_architecture/features/authentication/login/use_cases/login_with_email_and_password_usecase.dart';
import 'package:flutter_clean_architecture/infrastructure/authentication/adapters/fake/in_memory_authentication_gateway.dart';
import 'package:flutter_clean_architecture/infrastructure/authentication/adapters/fake/mock_authentication_gateway.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('$LoginWithEmailAndPasswordUseCase', () {
    test('should return left if login with email and password fails', () async {
      final mockAuthenticationGateway = MockAuthenticationGateway();
      when(() => mockAuthenticationGateway.logInWithEmailAndPassword(
          email: '', password: '')).thenAnswer((_) async => throw Exception());

      final useCase =
          await LoginWithEmailAndPasswordUseCase(mockAuthenticationGateway)
              .execute(params: const LoginWithEmailAndPasswordUseCaseParams());

      expect(useCase.isLeft(), true);
    });

    test('should return right if login with email and password succeed',
        () async {
      final authenticationGateway = InMemoryAuthenticationGateway();
      final useCase =
          await LoginWithEmailAndPasswordUseCase(authenticationGateway)
              .execute(params: const LoginWithEmailAndPasswordUseCaseParams());

      expect(useCase.isRight(), true);
    });
  });
}
