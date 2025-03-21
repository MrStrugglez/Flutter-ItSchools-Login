import 'dart:async';

import 'package:flutter_itschools_login/bloc/interfaces/auth_bloc.dart';
import 'package:flutter_itschools_login/data/repositories/interfaces/user_data_repository.dart';
import 'package:flutter_itschools_login/mixins/service_auth_header_mixin.dart';
import 'package:flutter_itschools_login/models/ui/auth_user.dart';
import 'package:flutter_itschools_login/services/interfaces/auth_service.dart';
import 'package:flutter_itschools_login/services/interfaces/user_details_service.dart';
import 'package:rxdart/rxdart.dart';

class UserAuthBloc with ServiceAuthHeadersMixin implements AuthBloc {
  final AuthService _authService;
  final UserDetailsService _userDetailsService;
  final UserDataRepository _userDataRepository;

  UserAuthBloc(
    this._authService,
    this._userDataRepository,
    this._userDetailsService,
  );

  final BehaviorSubject<AuthUser?> _userAuthController =
      BehaviorSubject<AuthUser?>();
  final BehaviorSubject<bool> _hasHashController = BehaviorSubject<bool>();

  @override
  Stream<AuthUser?> get userAuthStream => _userAuthController.stream;
  @override
  Stream<bool> get hasHashStream => _hasHashController.stream;

  @override
  Future<void> login(String username, String password) async {
    final authUser = await _authService.login(username, password);
    if (authUser != null) {
      await _userDataRepository.addUserData(authUser.username, authUser.hash);
      fetchCurrentAuthUser();
    } else {
      _userAuthController.sink.addError('Invalid username or password');
    }
  }

  Future<void> _loginWithHash(String username, String hash) async {
    final authUser = await _authService.loginWithHash(username, hash);

    if (authUser != null) {
      fetchCurrentAuthUser();
    } else {
      _userAuthController.sink.addError('Invalid email or hash');
    }
  }

  @override
  Future<void> logout() async {
    _authService.logout();
    _userDataRepository.deleteUserData();
    _userDetailsService.disposeUserGroups();
    _userAuthController.sink.add(null);
  }

  @override
  Future<void> fetchCurrentAuthUser() async {
    _userAuthController.sink.add(_authService.currentUser);
  }

  @override
  Future<void> fetchHashLogin() async {
    try {
      if (await isTokenValid()) {
        final savedUser = await _userDataRepository.getUserData();
        await _loginWithHash(savedUser.username, savedUser.hash);
        _hasHashController.sink.add(true);
      } else {
        throw Exception('Invalid JWT token while doing hash login');
      }
    } catch (e) {
      _hasHashController.sink.add(false);
    }
  }

  @override
  void dispose() {
    _userAuthController.close();
    _hasHashController.close();
  }
}
