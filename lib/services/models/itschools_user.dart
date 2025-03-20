import 'package:json_annotation/json_annotation.dart';

part 'itschools_user.g.dart';

@JsonSerializable()
class ItSchoolsUser {
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: '_id')
  final String id;
  final String username;
  final String firstname;
  final String surname;
  final bool enabled;
  final String? email;
  final Map<String, dynamic> grants;
  final bool deleted;
  final List<String> groups;
  final List<String> customGroups;
  final List<String> roles;
  final String grade;

  ItSchoolsUser({
    required this.userId,
    required this.id,
    required this.username,
    required this.firstname,
    required this.surname,
    required this.enabled,
    this.email,
    required this.grants,
    required this.deleted,
    required this.groups,
    required this.customGroups,
    required this.roles,
    required this.grade,
  });

  factory ItSchoolsUser.fromJson(Map<String, dynamic> json) =>
      _$ItSchoolsUserFromJson(json);
  Map<String, dynamic> toJson() => _$ItSchoolsUserToJson(this);
}
