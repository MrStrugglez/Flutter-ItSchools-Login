import 'package:json_annotation/json_annotation.dart';

part 'itschools_login_request.g.dart';

@JsonSerializable()
class ItschoolsLoginRequest {
  final String username;
  final String password;
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  final bool noHash;

  ItschoolsLoginRequest({
    required this.username,
    required this.password,
    this.noHash = false,
  });

  static bool _boolFromJson(dynamic value) => value == "1" || value == 1;
  static String _boolToJson(bool value) => value ? "1" : "0";

  factory ItschoolsLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$ItschoolsLoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ItschoolsLoginRequestToJson(this);
}
