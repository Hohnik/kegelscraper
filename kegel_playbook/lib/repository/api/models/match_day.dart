import 'package:json_annotation/json_annotation.dart';

part 'match_day.g.dart';

@JsonSerializable()
class MatchDay {
  final String id;
  final String seasonId;
  final String leagueId;
  final int number;
  final String name;
  final bool isCompleted;

  MatchDay({
    required this.id,
    required this.seasonId,
    required this.leagueId,
    required this.number,
    required this.name,
    required this.isCompleted,
  });

  factory MatchDay.fromJson(Map<String, dynamic> json) => _$MatchDayFromJson(json);
  Map<String, dynamic> toJson() => _$MatchDayToJson(this);
}
