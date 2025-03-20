import 'package:json_annotation/json_annotation.dart';

part 'itschools_device_features.g.dart';

@JsonSerializable()
class ItSchoolsDeviceFeatures {
  final int maxQuota;
  final int quotaUsed;
  final int xkv;
  final String storeUrl;

  ItSchoolsDeviceFeatures({
    required this.maxQuota,
    required this.quotaUsed,
    required this.xkv,
    required this.storeUrl,
  });

  factory ItSchoolsDeviceFeatures.fromJson(Map<String, dynamic> json) =>
      _$ItSchoolsDeviceFeaturesFromJson(json);
  Map<String, dynamic> toJson() => _$ItSchoolsDeviceFeaturesToJson(this);
}
