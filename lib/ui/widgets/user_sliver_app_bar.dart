import 'package:flutter/material.dart';
import 'package:flutter_itschools_login/bloc/interfaces/auth_bloc.dart';
import 'package:flutter_itschools_login/models/ui/auth_user.dart';
import 'package:flutter_itschools_login/ui/screens/error_screen.dart';
import 'package:flutter_itschools_login/ui/widgets/logout_button.dart';
import 'package:flutter_itschools_login/utils/injection_container.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserSliverAppBar extends StatefulWidget {
  final String title;

  const UserSliverAppBar({super.key, required this.title});

  @override
  State<UserSliverAppBar> createState() => UserSliverAppBarState();
}

class UserSliverAppBarState extends State<UserSliverAppBar> {
  final AuthBloc _authBloc = injector<AuthBloc>();
  final String _welcomeMessage = 'Welcome back!';

  @override
  void initState() {
    super.initState();
    _authBloc.fetchCurrentAuthUser();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 250.0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 20.0, bottom: 8.0),
        background: Container(
          padding: const EdgeInsets.only(left: 16.0, bottom: 60.0),
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [_buildWelcomeTitle(), _buildUsername()],
          ),
        ),
        title: _buildTitle(),
      ),
      actions: [LogoutButton()],
    );
  }

  Widget _buildWelcomeTitle() {
    return Text(
      _welcomeMessage,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _buildUsername() {
    return StreamBuilder<AuthUser?>(
      stream: _authBloc.userAuthStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final AuthUser authUser = snapshot.data!;
          return Text(
            authUser.username,
            style: Theme.of(context).textTheme.headlineSmall,
          );
        }

        if (snapshot.hasError) {
          _onError(snapshot.error);
        }

        return _buildLoader();
      },
    );
  }

  Widget _buildTitle() {
    return Text(widget.title, style: Theme.of(context).textTheme.titleLarge);
  }

  Widget _buildLoader() {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Theme.of(context).primaryColor,
        size: 100,
      ),
    );
  }

  void _onError(error) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ErrorScreen()),
    );
  }

  @override
  void dispose() {
    _authBloc.dispose();
    super.dispose();
  }
}
