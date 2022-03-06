import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/core/app/application/app_bloc.dart';
import 'package:flutter_clean_architecture/features/authentication/login/ui/login_page.dart';
import 'package:flutter_clean_architecture/features/home/ui/home_page.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
