import 'package:flutter_itschools_login/models/ui/auth_user.dart';

abstract class AuthService {
  Future<AuthUser?> login(String username, String password);
  Future<AuthUser?> loginWithHash(String username, String hash);
  AuthUser get currentUser;
  Future<void> logout();
}
