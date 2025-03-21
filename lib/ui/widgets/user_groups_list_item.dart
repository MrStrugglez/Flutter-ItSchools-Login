import 'package:flutter/material.dart';
import 'package:flutter_itschools_login/services/models/itschools_user_group.dart';

class UserGroupsListItem extends StatefulWidget {
  final ItSchoolsUserGroup group;
  final GestureTapCallback? onTap;

  const UserGroupsListItem({super.key, required this.group, this.onTap});

  @override
  UserGroupsListItemState createState() => UserGroupsListItemState();
}

class UserGroupsListItemState extends State<UserGroupsListItem> {
  @override
  Widget build(BuildContext context) {
    final String name = widget.group.name ?? 'Default Name';
    final int year = widget.group.year ?? 2025;
    final String initials =
        widget.group.name?.substring(0, 1).toUpperCase() ?? 'A';

    return Card(
      child: ListTile(
        leading: _buildInitialsAvatar(initials),
        title: _buildTitle(name),
        subtitle: _buildSubtitle(year),
        trailing: const Icon(Icons.chevron_right),
        onTap: widget.onTap,
      ),
    );
  }

  Widget _buildInitialsAvatar(String initials) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(initials, style: Theme.of(context).textTheme.titleLarge),
    );
  }

  Widget _buildTitle(String name) {
    return Text(
      name,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _buildSubtitle(int year) {
    return Text(year.toString(), style: Theme.of(context).textTheme.titleSmall);
  }
}
