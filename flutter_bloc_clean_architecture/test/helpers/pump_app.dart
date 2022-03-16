import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/app/application/app_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/routing/router.dart';
import 'package:flutter_bloc_clean_architecture/dependency_container.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp({String? initialLocation}) async {
    return pumpWidget(
      BlocProvider(
        // TODO(vincent): investigate why I cannot use getIt<AppBloc>() here.
        create: (_) => AppBloc(
          getIt(),
        ),
        child: Builder(
          builder: ((context) {
            final _appRouter = router(context, initialLocation);
            return MaterialApp.router(
              routerDelegate: _appRouter.routerDelegate,
              routeInformationParser: _appRouter.routeInformationParser,
            );
          }),
        ),
      ),
    );
  }
}
