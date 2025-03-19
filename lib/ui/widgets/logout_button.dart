import 'package:flutter/material.dart';
import 'package:flutter_itschools_login/bloc/interfaces/auth_bloc.dart';
import 'package:flutter_itschools_login/models/auth_user.dart';
import 'package:flutter_itschools_login/ui/screens/error_screen.dart';
import 'package:flutter_itschools_login/ui/screens/login_screen.dart';
import 'package:flutter_itschools_login/utils/auth_states.dart';
import 'package:flutter_itschools_login/utils/injection_container.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  final buttonText = "Logout";

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  final AuthBloc _authBloc = injector<AuthBloc>();

  AuthState _authState = AuthState.loggedIn;

  @override
  void initState() {
    _authBloc.userAuthStream.listen(_onLogout, onError: _onError);

    super.initState();
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
    return TextButton(
      onPressed: _logout,
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(Size(double.infinity, 50)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      child:
          _authState == AuthState.loading
              ? _buildLoader()
              : Text(widget.buttonText),
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
