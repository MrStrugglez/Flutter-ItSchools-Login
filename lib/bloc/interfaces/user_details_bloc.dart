import 'package:flutter_itschools_login/services/models/itschools_user_group.dart';

/// Defines the contract for managing user details
/// and their associated groups within the application.

abstract class UserDetailsBloc {
  /// A stream that emits a list of [ItSchoolsUserGroup] objects representing
  /// the groups associated with the current user.
  Stream<List<ItSchoolsUserGroup>> get userGroupsStream;

  /// Fetches the groups associated with the current user and updates the
  /// [userGroupsStream] with the latest data.
  ///
  /// This method should be called to ensure the user groups are up-to-date.
  Future<void> fetchCurrentUserGroups();

  /// Disposes of any resources used by the bloc.
  ///
  /// This method should be called when the blocis no longer needed to
  /// release resources and close streams.
  void dispose();
}
