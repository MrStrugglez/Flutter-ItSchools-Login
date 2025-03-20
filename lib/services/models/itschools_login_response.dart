import 'package:flutter_itschools_login/services/models/itschools_device_features.dart';
import 'package:flutter_itschools_login/services/models/itschools_max_file_size.dart';
import 'package:flutter_itschools_login/services/models/itschools_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'itschools_login_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ItSchoolsLoginResponse {
  final ItSchoolsUser user;
  final bool success;
  final String hash;
  final int maxQuota;
  final int quotaUsed;
  final int xkv;
  final String storeUrl;
  final ItSchoolsMaxFileSize maxFileSize;
  @JsonKey(name: 'device-features')
  final ItSchoolsDeviceFeatures deviceFeatures;
  final String firstname;
  final String surname;

  ItSchoolsLoginResponse({
    required this.user,
    required this.success,
    required this.hash,
    required this.maxQuota,
    required this.quotaUsed,
    required this.xkv,
    required this.storeUrl,
    required this.maxFileSize,
    required this.deviceFeatures,
    required this.firstname,
    required this.surname,
  });

  factory ItSchoolsLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$ItSchoolsLoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ItSchoolsLoginResponseToJson(this);
}
