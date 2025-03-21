import 'package:flutter/material.dart';
import 'package:flutter_itschools_login/bloc/interfaces/user_details_bloc.dart';
import 'package:flutter_itschools_login/mixins/load_manager_mixin.dart';
import 'package:flutter_itschools_login/services/models/itschools_user_group.dart';
import 'package:flutter_itschools_login/ui/screens/error_screen.dart';
import 'package:flutter_itschools_login/ui/widgets/user_groups_list_item.dart';
import 'package:flutter_itschools_login/ui/widgets/user_sliver_app_bar.dart';
import 'package:flutter_itschools_login/utils/injection_container.dart';

class UserGroupsScreen extends StatefulWidget {
  const UserGroupsScreen({super.key});

  @override
  State<UserGroupsScreen> createState() => _UserGroupsScreenState();
}

class _UserGroupsScreenState extends State<UserGroupsScreen>
    with LoadManagerMixin {
  // Dependencies
  final UserDetailsBloc _userDetailsBloc = injector<UserDetailsBloc>();

  // Constants
  final String _title = 'User Groups';

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
            var userGroups = _increaseGroupList(snapshot.data!);

            if (userGroups.isNotEmpty) {
              return CustomScrollView(
                slivers: [
                  UserSliverAppBar(title: _title),
                  SliverPadding(
                    padding: EdgeInsets.only(top: 16.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final group = userGroups[index];
                        return UserGroupsListItem(group: group);
                      }, childCount: userGroups.length),
                    ),
                  ),
                ],
              );
            }
          }

          if (snapshot.hasError) {
            _onError(snapshot.error);
          }

          return buildLoader(50, Colors.white);
        },
      ),
    );
  }

  // This is only done to show the full capabilities of this screen since the API only returns 3 items.
  List<ItSchoolsUserGroup> _increaseGroupList(
    List<ItSchoolsUserGroup> userGroups,
  ) {
    return List.generate(8, (_) => userGroups).expand((list) => list).toList();
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
