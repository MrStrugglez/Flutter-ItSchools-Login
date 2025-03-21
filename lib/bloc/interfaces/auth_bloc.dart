import 'package:flutter_itschools_login/models/ui/auth_user.dart';

/// Defines the contract for authentication-related operations.

abstract class AuthBloc {
  /// A stream that emits the current authenticated user or `null` if no user is authenticated.
  Stream<AuthUser?> get userAuthStream;

  /// A stream that emits a boolean indicating whether a hash-based login is available.
  Stream<bool> get hasHashStream;

  /// Logs in a user with the provided [username] and [password].
  ///
  /// Throws an exception if the login fails.
  ///
  /// [username] - The username of the user.
  /// [password] - The password of the user.
  Future<void> login(String username, String password);

  /// Logs out the currently authenticated user.
  ///
  /// Clears any stored authentication state.
  Future<void> logout();

  /// Fetches the currently authenticated user and updates the [userAuthStream].
  ///
  /// This method should be called to refresh the authentication state.
  Future<void> fetchCurrentAuthUser();

  /// Fetches the hash-based login status and updates the [hasHashStream].
  ///
  /// This method is useful for determining if hash-based login is supported or available and then performs hash-based login.
  Future<void> fetchHashLogin();

  /// Disposes of any resources used by the bloc.
  ///
  /// This method should be called when the [AuthBloc] is no longer needed to
  /// release resources and close streams.
  void dispose();
}
