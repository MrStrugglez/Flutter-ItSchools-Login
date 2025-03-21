import 'package:flutter/material.dart';
import 'package:flutter_itschools_login/bloc/interfaces/auth_bloc.dart';
import 'package:flutter_itschools_login/models/ui/auth_user.dart';
import 'package:flutter_itschools_login/ui/screens/error_screen.dart';
import 'package:flutter_itschools_login/ui/screens/login_screen.dart';
import 'package:flutter_itschools_login/utils/auth_states.dart';
import 'package:flutter_itschools_login/utils/injection_container.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  // Dependencies
  final AuthBloc _authBloc = injector<AuthBloc>();

  AuthState _authState = AuthState.loggedIn;

  // Constants
  final _buttonText = "Logout";

  @override
  void initState() {
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

    setLoggedOut();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _logout,
      icon:
          _authState == AuthState.loading
              ? _buildLoader()
              : Icon(Icons.exit_to_app, size: 30, color: Colors.white),
      padding: EdgeInsets.zero,
      iconSize: 30,
      splashRadius: 25,
      tooltip: _buttonText,
    );
  }

  Widget _buildLoader() {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.white,
        size: 35,
      ),
    );
  }

  void _logout() async {
    setLoading();

    // Added delay to simulate a longer logout request since this runs fairly quickly.
    await Future.delayed(Duration(seconds: 2));

    await _authBloc.logout();
  }

  void setLoading() {
    setState(() {
      _authState = AuthState.loading;
    });
  }

  void setLoggedOut() {
    setState(() {
      _authState = AuthState.loggedOut;
    });
  }
}
