import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

mixin ServiceAuthHeadersMixin {
  final _secureStorage = const FlutterSecureStorage();
  final _jwtTokenKey = "jwt_token";
  final _jwtRegex = r'unity\.jwt=([^;]+)';

  Future<String?> get _token async {
    return await _secureStorage.read(key: _jwtTokenKey);
  }

  Future<Map<String, String>> get headers async {
    final String? authToken = await _token;
    return {
      'Content-Type': 'application/json',
      if (authToken != null) 'Cookie': 'unity.jwt=$authToken',
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
    }
  }

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _jwtTokenKey, value: token);
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _jwtTokenKey);
  }

  Future<bool> isTokenValid() async {
    final token = await _token;
    if (token == null) return false;

    try {
      final parts = token.split('.');
      if (parts.length != 3) return false;

      final payload = parts[1];
      final normalized = base64.normalize(payload);
      final payloadMap = json.decode(utf8.decode(base64Url.decode(normalized)));

      if (payloadMap is! Map<String, dynamic>) return false;

      final exp = payloadMap['exp'];
      if (exp == null) return false;

      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now().isBefore(expiryDate);
    } catch (e) {
      print("Error decoding JWT: $e");
      return false;
    }
  }
}
