import 'package:json_annotation/json_annotation.dart';

part 'district.g.dart';

@JsonSerializable()
class District {
  final String id;
  final String name;
  final int seasonId;

  District({
    required this.id,
    required this.name,
    required this.seasonId,
  });

  factory District.fromJson(Map<String, dynamic> json) => _$DistrictFromJson(json);
  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}
