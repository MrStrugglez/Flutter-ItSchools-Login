import 'package:flutter_itschools_login/services/models/itschools_user_group.dart';

abstract class UserDetailsService {
  Future<List<ItSchoolsUserGroup>> getUserGroups(String username, String hash);
  List<ItSchoolsUserGroup> get currentUserGroups;
}
