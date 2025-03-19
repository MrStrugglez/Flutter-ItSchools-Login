import 'package:flutter_itschools_login/models/auth_user.dart';

abstract class AuthBloc {
  Stream<AuthUser?> get userAuthStream;
  Future<void> login(String email, String password);
  Future<void> logout();
  Future<void> fetchCurrentAuthUser();
  void dispose();
}
