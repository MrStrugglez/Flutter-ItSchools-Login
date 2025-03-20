import 'package:flutter_itschools_login/models/ui/auth_user.dart';

abstract class AuthBloc {
  Stream<AuthUser?> get userAuthStream;
  Stream<bool> get hasHashStream;
  Future<void> login(String email, String password);
  Future<void> logout();
  Future<void> fetchCurrentAuthUser();
  Future<void> fetchHasLoginHash();
  void dispose();
}
