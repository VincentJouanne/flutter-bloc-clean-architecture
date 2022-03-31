import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/dependency_container.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/domain/domain.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/fake/mock_authentication_gateway.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

Future<void> theDependenciesAreResolvedWithAnErrorWhenLoggingIn(
  WidgetTester tester,
) async {
  getIt.pushNewScope();

  final _mockAuthenticationGateway = MockAuthenticationGateway();
  when(
    () => _mockAuthenticationGateway.logInWithEmailAndPassword(
      email: 'vincent@gmail.com',
      password: 'Password123',
    ),
  ).thenAnswer(
    (_) async => Left(
      LogInWithEmailAndPasswordException.fromCode('user-disabled'),
    ),
  );

  when(() => _mockAuthenticationGateway.user)
      .thenAnswer((_) => Stream.value(User.empty));

  when(() => _mockAuthenticationGateway.currentUser)
      .thenAnswer((_) => User.empty);

  await resolveDependencies(
    mockAuthenticationGateway: _mockAuthenticationGateway,
  );
}
