import 'package:flutter_itschools_login/models/DTO/user_data_dto.dart';

/// Defines the contract for managing user data.

abstract class UserDataRepository {
  /// Adds user data to the repository.
  ///
  /// [username] - The username of the user.
  /// [hash] The hashed representation of the user's sensitive data (e.g., password).
  ///
  /// Returns a [Future] that resolves to an integer, which represents
  /// an identifier.
  Future<int> addUserData(String username, String hash);

  /// Retrieves the user data from the repository.
  ///
  /// Returns a [Future] that resolves to a [UserDataDto] containing the user's data.
  Future<UserDataDto> getUserData();

  /// Deletes the user data from the repository.
  ///
  /// This operation removes all stored user data.
  Future<void> deleteUserData();
}
