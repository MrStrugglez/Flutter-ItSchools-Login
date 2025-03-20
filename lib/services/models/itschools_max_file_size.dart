import 'package:json_annotation/json_annotation.dart';

part 'itschools_max_file_size.g.dart';

@JsonSerializable()
class ItSchoolsMaxFileSize {
  final int audio;
  final int excel;
  final int image;
  final int pdf;
  final int powerpoint;
  final int video;
  final int word;

  ItSchoolsMaxFileSize({
    required this.audio,
    required this.excel,
    required this.image,
    required this.pdf,
    required this.powerpoint,
    required this.video,
    required this.word,
  });

  factory ItSchoolsMaxFileSize.fromJson(Map<String, dynamic> json) =>
      _$ItSchoolsMaxFileSizeFromJson(json);
  Map<String, dynamic> toJson() => _$ItSchoolsMaxFileSizeToJson(this);
}
