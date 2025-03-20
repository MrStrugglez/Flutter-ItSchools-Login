import 'package:flutter_itschools_login/bloc/interfaces/user_details_bloc.dart';
import 'package:flutter_itschools_login/data/repositories/interfaces/user_data_repository.dart';
import 'package:flutter_itschools_login/services/interfaces/user_details_service.dart';
import 'package:flutter_itschools_login/services/models/itschools_user_group.dart';
import 'package:rxdart/rxdart.dart';

class UserDetailsBlocImpl implements UserDetailsBloc {
  final UserDetailsService _userDetailsService;
  final UserDataRepository _userDataRepository;

  UserDetailsBlocImpl(this._userDetailsService, this._userDataRepository);

  final BehaviorSubject<List<ItSchoolsUserGroup>> _userGroupsController =
      BehaviorSubject<List<ItSchoolsUserGroup>>();

  @override
  Stream<List<ItSchoolsUserGroup>> get userGroupsStream =>
      _userGroupsController.stream;

  @override
  Future<void> fetchCurrentUserGroups() async {
    final (String username, String hash) = await _userDataRepository
        .getUserData()
        .then((userData) => (userData.username, userData.hash));
    final List<ItSchoolsUserGroup> userGroups = await _userDetailsService
        .getUserGroups(username, hash);
    _userGroupsController.sink.add(userGroups);
  }

  @override
  void dispose() {
    _userGroupsController.close();
  }
}
