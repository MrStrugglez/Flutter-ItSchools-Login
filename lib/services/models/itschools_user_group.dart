import 'package:json_annotation/json_annotation.dart';

part 'itschools_user_group.g.dart';

@JsonSerializable()
class ItSchoolsUserGroup {
  @JsonKey(name: "group_id")
  final int? groupId;
  @JsonKey(name: "_id")
  final String? id;
  final String? code;
  final String? grade;
  final String? name;
  final bool? private;
  final int? updated;
  final int? created;
  final int? year;
  final String? language;
  final String? source;
  final dynamic root;
  final String? metadata;
  final bool? deleted;
  final dynamic deletedDate;
  final int? owner;
  final int? updatedBy;
  final dynamic deletedBy;
  final String? subject;
  final int? start;
  final int? end;
  final bool? systemGroup;
  final dynamic memberParents;
  final bool? educatorControl;
  @JsonKey(name: "subject_id")
  final int? subjectId;

  ItSchoolsUserGroup({
    this.groupId,
    this.id,
    this.code,
    this.grade,
    this.name,
    this.private,
    this.updated,
    this.created,
    this.year,
    this.language,
    this.source,
    this.root,
    this.metadata,
    this.deleted,
    this.deletedDate,
    this.owner,
    this.updatedBy,
    this.deletedBy,
    this.subject,
    this.start,
    this.end,
    this.systemGroup,
    this.memberParents,
    this.educatorControl,
    this.subjectId,
  });

  factory ItSchoolsUserGroup.fromJson(Map<String, dynamic> json) =>
      _$ItSchoolsUserGroupFromJson(json);

  Map<String, dynamic> toJson() => _$ItSchoolsUserGroupToJson(this);
}
