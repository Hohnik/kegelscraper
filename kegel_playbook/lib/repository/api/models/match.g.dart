// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Match _$MatchFromJson(Map<String, dynamic> json) => Match(
      id: json['id'] as String,
      seasonId: json['seasonId'] as String,
      districtId: json['districtId'] as String,
      regionId: json['regionId'] as String,
      leagueId: json['leagueId'] as String,
      matchDayId: json['matchDayId'] as String,
      date: Match._dateFromJson(json['date'] as String),
      time: Match._timeFromJson(json['time'] as String),
      homeTeamName: json['homeTeamName'] as String,
      homeTeamTotal: (json['homeTeamTotal'] as num).toInt(),
      homeTeamPoints: (json['homeTeamPoints'] as num).toDouble(),
      homeTeamSets: (json['homeTeamSets'] as num).toDouble(),
      awayTeamName: json['awayTeamName'] as String,
      awayTeamTotal: (json['awayTeamTotal'] as num).toInt(),
      awayTeamPoints: (json['awayTeamPoints'] as num).toDouble(),
      awayTeamSets: (json['awayTeamSets'] as num).toDouble(),
      status: json['status'] as String,
      info: json['info'] as String?,
      streamLink: json['streamLink'] as String?,
    );

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
      'id': instance.id,
      'seasonId': instance.seasonId,
      'districtId': instance.districtId,
      'regionId': instance.regionId,
      'leagueId': instance.leagueId,
      'matchDayId': instance.matchDayId,
      'date': Match._dateToJson(instance.date),
      'time': Match._timeToJson(instance.time),
      'homeTeamName': instance.homeTeamName,
      'homeTeamTotal': instance.homeTeamTotal,
      'homeTeamPoints': instance.homeTeamPoints,
      'homeTeamSets': instance.homeTeamSets,
      'awayTeamName': instance.awayTeamName,
      'awayTeamTotal': instance.awayTeamTotal,
      'awayTeamPoints': instance.awayTeamPoints,
      'awayTeamSets': instance.awayTeamSets,
      'status': instance.status,
      'info': instance.info,
      'streamLink': instance.streamLink,
    };
