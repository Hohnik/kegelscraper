import 'package:json_annotation/json_annotation.dart';

part 'region.g.dart';

@JsonSerializable()
class Region {
  final String id;
  final String tenantId;
  final String countryId;
  final String seasonId;
  final String districtId;
  final String name;

  Region({
    required this.id,
    required this.tenantId,
    required this.countryId,
    required this.seasonId,
    required this.districtId,
    required this.name,
  });

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);
}
