import 'package:flutter_itschools_login/data/providers/database_provider.dart';
import 'package:flutter_itschools_login/data/repositories/interfaces/user_data_repository.dart';
import 'package:flutter_itschools_login/models/DTO/user_data_dto.dart';

class UserDataRepositoryImpl extends UserDataRepository {
  // Dependencies
  final DatabaseProvider databaseProvider;
  UserDataDto? _userData;

  UserDataRepositoryImpl({required this.databaseProvider});

  @override
  Future<int> addUserData(String username, String hash) async {
    final database = await databaseProvider.database;

    final userDataId = await database.transaction<int>((txn) async {
      final id = await txn.rawInsert(
        '''INSERT INTO ${DatabaseProvider.userDataTable}
        (${DatabaseProvider.usernameFieldName}, 
        ${DatabaseProvider.hashFieldName}) VALUES(?,?)''',
        [username, hash],
      );
      return id;
    });

    return userDataId;
  }

  @override
  Future<UserDataDto> getUserData() async {
    // Return userData is already present.
    if (_userData != null) {
      return Future.value(_userData!);
    }

    final database = await databaseProvider.database;

    // Only select first entry from the UserData table.
    final List<Map<String, dynamic>> maps = await database.rawQuery(
      '''SELECT ${DatabaseProvider.idFieldName}, 
      ${DatabaseProvider.usernameFieldName}, 
      ${DatabaseProvider.hashFieldName} 
      FROM ${DatabaseProvider.userDataTable} LIMIT 1''',
    );

    if (maps.isEmpty) {
      throw Exception('No user data found');
    }

    _userData = UserDataDto(
      id: maps[0][DatabaseProvider.idFieldName],
      username: maps[0][DatabaseProvider.usernameFieldName],
      hash: maps[0][DatabaseProvider.hashFieldName],
    );

    return Future.value(_userData!);
  }

  @override
  Future<void> deleteUserData() async {
    final database = await databaseProvider.database;

    // Delete all entries in UserData table.
    await database.transaction<void>((txn) async {
      await txn.delete(DatabaseProvider.userDataTable);
    });

    _userData = null;
  }
}
