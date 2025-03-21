import 'package:flutter/material.dart';
import 'package:flutter_itschools_login/bloc/interfaces/auth_bloc.dart';
import 'package:flutter_itschools_login/mixins/load_manager_mixin.dart';
import 'package:flutter_itschools_login/models/ui/auth_user.dart';
import 'package:flutter_itschools_login/ui/screens/error_screen.dart';
import 'package:flutter_itschools_login/ui/screens/user_groups_screen.dart';
import 'package:flutter_itschools_login/ui/widgets/bordered_text_field.dart';
import 'package:flutter_itschools_login/ui/widgets/login_button.dart';
import 'package:flutter_itschools_login/ui/widgets/styled_background_widget.dart';
import 'package:flutter_itschools_login/utils/auth_states.dart';
import 'package:flutter_itschools_login/utils/injection_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with LoadManagerMixin {
  // Dependencies
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final AuthBloc _authBloc = injector<AuthBloc>();

  // Constants
  final logoPath = "assets/images/spinning_logo.png";
  final title = "Login";

  @override
  void initState() {
    super.initState();
    // Listen for any emmitions from the Auth stream. This allows the state to update when the user is logged in.
    _authBloc.userAuthStream.listen(_onUserAuth, onError: _onError);
  }

  void _onUserAuth(AuthUser? user) {
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserGroupsScreen()),
      );
    } else {
      _onError("Incorrect email or password");
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
    return Scaffold(
      body:
          authState == AuthState.loading
              ? buildLoader(100, Theme.of(context).primaryColor)
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: StyledBackgroundWidget(
                    logoPath: logoPath,
                    icon: Icons.adjust_sharp,
                    drapeColor: Theme.of(context).colorScheme.secondary,
                    child: _buildLoginForm(),
                  ),
                ),
              ),
    );
  }

  Widget _buildLoginTitle() {
    return Center(
      child: Text(title, style: Theme.of(context).textTheme.headlineLarge),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        SizedBox(height: 330),
        _buildLoginTitle(),
        SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              BorderedTextField(
                label: "Email",
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: _emailFocusNode,
                nextFocusNode: _passwordFocusNode,
              ),
              const SizedBox(height: 20),
              BorderedTextField(
                label: "Password",
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                focusNode: _passwordFocusNode,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              LoginButton(onPressed: _login),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    setLoading(this);

    await _authBloc.login(email, password);
  }

  @override
  void dispose() {
    _authBloc.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
