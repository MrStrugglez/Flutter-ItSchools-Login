import 'package:flutter_itschools_login/services/models/itschools_user_group.dart';

abstract class UserDetailsBloc {
  Stream<List<ItSchoolsUserGroup>> get userGroupsStream;
  Future<void> fetchCurrentUserGroups();
  void dispose();
}
