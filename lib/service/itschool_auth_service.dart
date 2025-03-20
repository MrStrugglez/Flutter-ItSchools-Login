import 'package:flutter_itschools_login/models/ui/auth_user.dart';
import 'package:flutter_itschools_login/service/interfaces/auth_service.dart';
import 'package:flutter_itschools_login/service/models/itschools_login_request.dart';
import 'package:flutter_itschools_login/service/models/itschools_login_response.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_itschools_login/extensions/uri_endpoints.dart';

class ItSchoolsAuthService implements AuthService {
  late AuthUser _currentAuthUser;

  @override
  Future<AuthUser?> login(String username, String password) async {
    final request = ItschoolsLoginRequest(
      username: username,
      password: password,
    );

    return _loginRequest(request);
  }

  @override
  Future<AuthUser?> loginWithHash(String username, String hash) {
    final request = ItschoolsLoginRequest(
      username: username,
      password: hash,
      noHash: true,
    );

    return _loginRequest(request);
  }

  Future<AuthUser?> _loginRequest(ItschoolsLoginRequest request) async {
    try {
      final http.Response response = await http.post(
        UriEndpoints.itSchoolLoginPath,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = jsonDecode(response.body);
        final ItSchoolsLoginResponse loginResponse =
            ItSchoolsLoginResponse.fromJson(responseJson);

        _currentAuthUser = AuthUser(
          username: loginResponse.user.username,
          hash: loginResponse.hash,
        );

        return _currentAuthUser;
      } else {
        print('Failed to login. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Failed to login. Error: $e');
      return null;
    }
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
