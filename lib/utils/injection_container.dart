import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_itschools_login/bloc/interfaces/auth_bloc.dart';
import 'package:flutter_itschools_login/bloc/user_auth_bloc.dart';
import 'package:flutter_itschools_login/data/providers/database_provider.dart';
import 'package:flutter_itschools_login/data/repositories/interfaces/user_data_repository.dart';
import 'package:flutter_itschools_login/data/repositories/user_data_repository_impl.dart';
import 'package:flutter_itschools_login/service/interfaces/auth_service.dart';
import 'package:flutter_itschools_login/service/itschool_auth_service.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

void setup() {
  debugPrint("Dependency injection started");

  //Database
  injector.registerLazySingleton<DatabaseProvider>(() => DatabaseProvider());

  //Repositories
  injector.registerLazySingleton<UserDataRepository>(
    () =>
        UserDataRepositoryImpl(databaseProvider: injector<DatabaseProvider>()),
  );

  //Auth Service
  injector.registerLazySingleton<AuthService>(() => ItSchoolsAuthService());

  //Bloc
  injector.registerFactory<AuthBloc>(
    () => UserAuthBloc(injector<AuthService>(), injector<UserDataRepository>()),
  );
}
