import 'package:flutter_itschools_login/models/auth_user.dart';

abstract class AuthService {
  Future<AuthUser?> login(String email, String password);
  AuthUser getCurrentUser();
  Future<void> logout();
}
