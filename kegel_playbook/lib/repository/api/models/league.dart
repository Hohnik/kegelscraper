import 'package:json_annotation/json_annotation.dart';

part 'league.g.dart';

@JsonSerializable()
class League {
  final String id;
  final String seasonId;
  final String districtId;
  final String regionId;
  final String name;
  final bool isActive;
  final String leagueManager;
  final String? phone1;
  final String? phone2;
  final String? phone3;
  final String? email;

  League({
    required this.id,
    required this.seasonId,
    required this.districtId,
    required this.regionId,
    required this.name,
    required this.isActive,
    required this.leagueManager,
    this.phone1,
    this.phone2,
    this.phone3,
    this.email,
  });

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);
  Map<String, dynamic> toJson() => _$LeagueToJson(this);
}
