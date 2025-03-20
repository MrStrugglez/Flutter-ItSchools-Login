import 'package:flutter_secure_storage/flutter_secure_storage.dart';

mixin ServiceAuthHeadersMixin {
  final _secureStorage = const FlutterSecureStorage();
  final _jwtTokenKey = "jwt_token";
  final _jwtRegex = r'unity.jwt=([^;]+)';

  Future<String?> get _token async {
    return await _secureStorage.read(key: _jwtTokenKey);
  }

  Future<Map<String, String>> get headers async {
    final String? authToken = await _token;
    return {
      'Content-Type': 'application/json',
      if (authToken != null) 'Cookie': authToken,
    };
  }

  Future<void> setJWTFromHeaders(Map<String, String> headers) async {
    final cookie = headers['set-cookie'];
    if (cookie != null) {
      final jwtMatch = RegExp(_jwtRegex).firstMatch(cookie);
      if (jwtMatch != null) {
        final String? jwt = jwtMatch.group(1);
        if (jwt != null) {
          await saveToken(jwt);
        } else {
          print("JWT failed to save");
        }
      } else {
        print("JWT failed to save");
      }
      saveToken(cookie);
    }
  }

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _jwtTokenKey, value: token);
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _jwtTokenKey);
  }
}
