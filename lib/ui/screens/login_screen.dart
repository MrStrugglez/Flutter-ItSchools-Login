import 'package:flutter/material.dart';
import 'package:flutter_itschools_login/bloc/interfaces/auth_bloc.dart';
import 'package:flutter_itschools_login/models/ui/auth_user.dart';
import 'package:flutter_itschools_login/ui/screens/error_screen.dart';
import 'package:flutter_itschools_login/ui/screens/user_groups_screen.dart';
import 'package:flutter_itschools_login/ui/widgets/bordered_text_field.dart';
import 'package:flutter_itschools_login/ui/widgets/login_button.dart';
import 'package:flutter_itschools_login/utils/auth_states.dart';
import 'package:flutter_itschools_login/utils/injection_container.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final logoPath = "assets/images/3x4_genetics_logo.png";
  final title = "Login";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final AuthBloc _authBloc = injector<AuthBloc>();

  AuthState _authState = AuthState.loggedOut;

  @override
  void initState() {
    _authBloc.userAuthStream.listen(_onUserAuth, onError: _onError);

    super.initState();
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

    setLoggedOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _authState == AuthState.loading
              ? _buildLoader()
              : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 50,
                        bottom: 16,
                      ),
                      child: Image.asset(logoPath),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLoginTitle(),
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
                ),
              ),
    );
  }

  Text _buildLoginTitle() {
    return Text(title, style: Theme.of(context).textTheme.headlineMedium);
  }

  Widget _buildLoader() {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Theme.of(context).primaryColor,
        size: 100,
      ),
    );
  }

  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    setLoading();

    await _authBloc.login(email, password);
  }

  void setLoading() {
    setState(() {
      _authState = AuthState.loading;
    });
  }

  void setLoggedIn() {
    setState(() {
      _authState = AuthState.loggedIn;
    });
  }

  void setLoggedOut() {
    setState(() {
      _authState = AuthState.loggedOut;
    });
  }

  @override
  void dispose() {
    _authBloc.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
