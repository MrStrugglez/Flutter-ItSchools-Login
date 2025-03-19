import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_itschools_login/bloc/interfaces/auth_bloc.dart';
import 'package:flutter_itschools_login/bloc/user_auth_bloc.dart';
import 'package:flutter_itschools_login/service/interfaces/auth_service.dart';
import 'package:flutter_itschools_login/service/itschool_auth_service.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

void setup() {
  debugPrint("Dependency injection started");

  //Auth Service
  injector.registerLazySingleton<AuthService>(() => ItSchoolsAuthService());

  //Bloc
  injector.registerFactory<AuthBloc>(
    () => UserAuthBloc(injector<AuthService>()),
  );
}
