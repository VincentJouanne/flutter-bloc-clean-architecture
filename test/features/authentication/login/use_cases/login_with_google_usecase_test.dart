import 'package:flutter_clean_architecture/features/authentication/login/use_cases/login_with_google_usecase.dart';
import 'package:flutter_clean_architecture/infrastructure/authentication/adapters/fake/in_memory_authentication_gateway.dart';
import 'package:flutter_clean_architecture/infrastructure/authentication/adapters/fake/mock_authentication_gateway.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('$LoginWithGoogleUseCase', () {
    test('should return left if login with google fails', () async {
      final mockAuthenticationGateway = MockAuthenticationGateway();
      when(() => mockAuthenticationGateway.logInWithGoogle())
          .thenAnswer((_) async => throw Exception());

      final useCase = await LoginWithGoogleUseCase(mockAuthenticationGateway)
          .execute(params: LoginWithGoogleUseCaseParams());

      expect(useCase.isLeft(), true);
    });

    test('should return right if login with google succeed', () async {
      final authenticationGateway = InMemoryAuthenticationGateway();
      final useCase = await LoginWithGoogleUseCase(authenticationGateway)
          .execute(params: LoginWithGoogleUseCaseParams());

      expect(useCase.isRight(), true);
    });
  });
}
