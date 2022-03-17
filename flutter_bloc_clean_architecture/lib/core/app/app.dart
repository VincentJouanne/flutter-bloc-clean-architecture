import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/app/application/app_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/routing/router.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationGateway authenticationGateway,
  })  : _authenticationGateway = authenticationGateway,
        super(key: key);

  final AuthenticationGateway _authenticationGateway;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationGateway,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationGateway: _authenticationGateway,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _appRouter = router(context);

    return MaterialApp.router(
      routerDelegate: _appRouter.routerDelegate,
      routeInformationParser: _appRouter.routeInformationParser,
    );
  }
}
