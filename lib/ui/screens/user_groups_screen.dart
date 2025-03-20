import 'package:flutter/material.dart';
import 'package:flutter_itschools_login/bloc/interfaces/user_details_bloc.dart';
import 'package:flutter_itschools_login/services/models/itschools_user_group.dart';
import 'package:flutter_itschools_login/ui/screens/error_screen.dart';
import 'package:flutter_itschools_login/utils/injection_container.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserGroupsScreen extends StatefulWidget {
  const UserGroupsScreen({super.key});

  @override
  State<UserGroupsScreen> createState() => _UserGroupsScreenState();
}

class _UserGroupsScreenState extends State<UserGroupsScreen> {
  final UserDetailsBloc _userDetailsBloc = injector<UserDetailsBloc>();

  @override
  void initState() {
    super.initState();
    _userDetailsBloc.fetchCurrentUserGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ItSchoolsUserGroup>>(
        stream: _userDetailsBloc.userGroupsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userGroups = snapshot.data!;

            if (userGroups.isNotEmpty) {
              return ListView.builder(
                itemCount: userGroups.length,
                itemBuilder: (context, index) {
                  final group = userGroups[index];
                  return ListTile(title: Text(group.name!));
                },
              );
            }
          }

          if (snapshot.hasError) {
            _onError(snapshot.error);
          }

          return _buildLoader();
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

  void _onError(error) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ErrorScreen()),
    );
  }

  @override
  void dispose() {
    _userDetailsBloc.dispose();
    super.dispose();
  }
}
