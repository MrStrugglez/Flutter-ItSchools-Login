import 'package:flutter_itschools_login/models/ui/auth_user.dart';

/// Defines the contract for authentication services.

abstract class AuthService {
  /// Logs in a user using their username and password.
  ///
  /// Returns an [AuthUser] object if the login is successful, or `null` if
  /// the login fails.
  ///
  /// [username] - The username of the user.
  /// [password] - The password of the user.
  Future<AuthUser?> login(String username, String password);

  /// Logs in a user using their username and a precomputed hash.
  ///
  /// Returns an [AuthUser] object if the login is successful, or `null` if
  /// the login fails.
  ///
  /// [username] - The username of the user.
  /// [hash] The hashed representation of the user's sensitive data (e.g., password).
  Future<AuthUser?> loginWithHash(String username, String hash);

  /// Retrieves the currently authenticated user.
  ///
  /// Returns an [AuthUser] object representing the currently logged-in user,
  /// or `null` if no user is logged in.
  AuthUser? get currentUser;

  /// Logs out the currently authenticated user.
  ///
  /// This method clears the current user's session and performs any necessary
  /// cleanup related to authentication.
  Future<void> logout();
}
