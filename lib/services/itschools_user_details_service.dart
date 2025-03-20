import 'dart:convert';

import 'package:flutter_itschools_login/extensions/uri_endpoints.dart';
import 'package:flutter_itschools_login/mixins/service_auth_header_mixin.dart';
import 'package:flutter_itschools_login/services/interfaces/user_details_service.dart';
import 'package:flutter_itschools_login/services/models/itschools_user_group.dart';
import 'package:http/http.dart' as http;

class ItSchoolsUserDetailsService
    with ServiceAuthHeadersMixin
    implements UserDetailsService {
  late List<ItSchoolsUserGroup> _currentUserGroups;

  @override
  List<ItSchoolsUserGroup> get currentUserGroups => _currentUserGroups;

  @override
  Future<List<ItSchoolsUserGroup>> getUserGroups(
    String username,
    String hash,
  ) async {
    try {
      final http.Response response = await http.get(
        UriEndpoints.getItSchoolUserGroupsPath(username),
        headers: await headers,
      );

      if (response.statusCode == 200) {
        setJWTFromHeaders(response.headers);
        final List<dynamic> responseJson = jsonDecode(response.body);
        _currentUserGroups =
            responseJson.map((json) {
              final test = ItSchoolsUserGroup.fromJson(json);
              return test;
            }).toList();

        return _currentUserGroups;
      } else {
        print('Failed to login. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Failed to login. Error: $e');
      return [];
    }
  }
}
