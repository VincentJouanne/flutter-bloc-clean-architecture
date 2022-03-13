import 'package:flutter_bloc_clean_architecture/features/authentication/signup/use_cases/signup_usecase.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/fake/in_memory_authentication_gateway.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/fake/mock_authentication_gateway.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('$SignUpUseCase', () {
    test(
        'shoud be left if an exception occurs while signing up through authentication gateway',
        () async {
      final mockAuthenticationGateway = MockAuthenticationGateway();
      when(() => mockAuthenticationGateway.signUp(email: '', password: ''))
          .thenAnswer((_) async => throw Exception());

      final useCase = await SignUpUseCase(mockAuthenticationGateway)
          .execute(params: const SignUpUseCaseParams());

      expect(useCase.isLeft(), true);
    });

    test('shoud be right if sign up through authentication gateway succeed',
        () async {
      final inMemoryAuthenticationGateway = InMemoryAuthenticationGateway();
      final useCase = await SignUpUseCase(inMemoryAuthenticationGateway)
          .execute(params: const SignUpUseCaseParams());

      expect(useCase.isRight(), true);
    });
  });
}
