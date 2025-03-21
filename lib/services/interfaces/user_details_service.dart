import 'package:flutter_itschools_login/services/models/itschools_user_group.dart';

/// Defines the contract for a service

abstract class UserDetailsService {
  /// Retrieves a list of user groups associated with the specified username.
  ///
  /// [username] - The username of the user.
  ///
  /// Returns a [Future] that resolves to a list of [ItSchoolsUserGroup].
  Future<List<ItSchoolsUserGroup>> getUserGroups(String username);

  /// A cached list of user groups for the current user.
  ///
  /// This property may return `null` if the user groups have not been loaded.
  List<ItSchoolsUserGroup>? get currentUserGroups;

  /// Disposes of any resources or cached data related to user groups.
  ///
  /// This method should be called to clean up when the user groups are no longer needed.
  void disposeUserGroups();
}
