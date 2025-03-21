/// Defines the DTO that handles information between the Database Layer and the Domain Layer
///
class UserDataDto {
  final int id;
  final String username;
  final String hash;

  UserDataDto({required this.id, required this.username, required this.hash});
}
