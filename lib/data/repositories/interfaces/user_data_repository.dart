import 'package:flutter_itschools_login/models/DTO/user_data_dto.dart';

abstract class UserDataRepository {
  Future<int> addUserData(String username, String hash);
  Future<UserDataDto> getUserData();
}
