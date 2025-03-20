import 'package:flutter/material.dart';
import 'package:flutter_itschools_login/bloc/interfaces/auth_bloc.dart';
import 'package:flutter_itschools_login/themes/theme_config.dart';
import 'package:flutter_itschools_login/ui/screens/login_screen.dart';
import 'package:flutter_itschools_login/ui/screens/user_groups_screen.dart';
import 'package:flutter_itschools_login/utils/injection_container.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthBloc _authBloc = injector<AuthBloc>();

  @override
  void initState() {
    _authBloc.fetchHashLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ItSchools Login',
      theme: ThemeConfig.geneticsTheme,
      home: StreamBuilder<bool>(
        stream: _authBloc.hasHashStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return UserGroupsScreen();
            } else {
              return LoginScreen();
            }
          } else {
            return _buildLoader();
          }
        },
      ),
    );
  }

  Widget _buildLoader() {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Theme.of(context).primaryColor,
        size: 100,
      ),
    );
  }

  @override
  void dispose() {
    _authBloc.dispose();
    super.dispose();
  }
}
