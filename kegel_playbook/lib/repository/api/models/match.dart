import 'package:json_annotation/json_annotation.dart';

part 'match.g.dart';

@JsonSerializable()
class Match {
  final String id;
  final String seasonId;
  final String districtId;
  final String regionId;
  final String leagueId;
  final String matchDayId;
  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime date;
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime time;
  final String homeTeamName;
  final int homeTeamTotal;
  final double homeTeamPoints;
  final double homeTeamSets;
  final String awayTeamName;
  final int awayTeamTotal;
  final double awayTeamPoints;
  final double awayTeamSets;
  final String status;
  final String? info;
  final String? streamLink;

  Match({
    required this.id,
    required this.seasonId,
    required this.districtId,
    required this.regionId,
    required this.leagueId,
    required this.matchDayId,
    required this.date,
    required this.time,
    required this.homeTeamName,
    required this.homeTeamTotal,
    required this.homeTeamPoints,
    required this.homeTeamSets,
    required this.awayTeamName,
    required this.awayTeamTotal,
    required this.awayTeamPoints,
    required this.awayTeamSets,
    required this.status,
    this.info,
    this.streamLink,
  });

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);
  Map<String, dynamic> toJson() => _$MatchToJson(this);

  static DateTime _dateFromJson(String date) => DateTime.parse(date);
  static String _dateToJson(DateTime date) => date.toIso8601String();
  static DateTime _timeFromJson(String time) => DateTime.parse('1970-01-01T$time');
  static String _timeToJson(DateTime time) => time.toIso8601String().split('T')[1];
}
