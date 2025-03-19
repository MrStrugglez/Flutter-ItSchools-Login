import 'dart:async';

import 'package:flutter_itschools_login/bloc/interfaces/auth_bloc.dart';
import 'package:flutter_itschools_login/models/auth_user.dart';
import 'package:flutter_itschools_login/service/interfaces/auth_service.dart';
import 'package:rxdart/rxdart.dart';

class UserAuthBloc implements AuthBloc {
  final AuthService _authService;

  UserAuthBloc(this._authService);

  final BehaviorSubject<AuthUser?> _userAuthController =
      BehaviorSubject<AuthUser?>();

  @override
  Stream<AuthUser?> get userAuthStream => _userAuthController.stream;

  @override
  Future<void> login(String email, String password) async {
    final authUser = await _authService.login(email, password);
    if (authUser != null) {
      fetchCurrentAuthUser();
    } else {
      _userAuthController.sink.addError('Invalid email or password');
    }
  }

  @override
  Future<void> logout() async {
    _authService.logout();
    _userAuthController.sink.add(null);
  }

  @override
  Future<void> fetchCurrentAuthUser() async {
    _userAuthController.sink.add(_authService.getCurrentUser());
  }

  @override
  void dispose() {
    _userAuthController.close();
  }
}
