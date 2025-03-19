import 'package:flutter_itschools_login/models/auth_user.dart';
import 'package:flutter_itschools_login/service/interfaces/auth_service.dart';

class ItSchoolsAuthService implements AuthService {
  late AuthUser _currentAuthUser;

  @override
  Future<AuthUser?> login(String email, String password) async {
    //TODO add login logic here
    return null;
  }

  @override
  AuthUser getCurrentUser() {
    return _currentAuthUser;
  }

  @override
  Future<void> logout() async {
    //TODO add logout logic by clearing current user and local stores
  }
}
