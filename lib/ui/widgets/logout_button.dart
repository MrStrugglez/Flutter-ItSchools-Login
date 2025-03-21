import 'package:flutter/material.dart';
import 'package:flutter_itschools_login/bloc/interfaces/auth_bloc.dart';
import 'package:flutter_itschools_login/mixins/load_manager_mixin.dart';
import 'package:flutter_itschools_login/models/ui/auth_user.dart';
import 'package:flutter_itschools_login/ui/screens/error_screen.dart';
import 'package:flutter_itschools_login/ui/screens/login_screen.dart';
import 'package:flutter_itschools_login/utils/auth_states.dart';
import 'package:flutter_itschools_login/utils/injection_container.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> with LoadManagerMixin {
  // Dependencies
  final AuthBloc _authBloc = injector<AuthBloc>();

  // Constants
  final _buttonText = "Logout";

  @override
  void initState() {
    setLoggedIn(this);
    super.initState();
    // Listen for any emmitions from the Auth stream. The stream emmits null if the user has been logged out.
    _authBloc.userAuthStream.listen(_onLogout, onError: _onError);
  }

  void _onLogout(AuthUser? user) {
    if (user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      _onError("Failed to logout");
    }
  }

  void _onError(error) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ErrorScreen()),
    );

    setLoggedOut(this);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _logout,
      icon:
          authState == AuthState.loading
              ? buildLoader(35, Colors.white)
              : Icon(Icons.exit_to_app, size: 30, color: Colors.white),
      padding: EdgeInsets.zero,
      iconSize: 30,
      splashRadius: 25,
      tooltip: _buttonText,
    );
  }

  void _logout() async {
    setLoading(this);

    // Added delay to simulate a longer logout request since this runs fairly quickly.
    await Future.delayed(Duration(seconds: 2));

    await _authBloc.logout();
  }
}
