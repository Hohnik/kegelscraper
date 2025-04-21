// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchDay _$MatchDayFromJson(Map<String, dynamic> json) => MatchDay(
      id: json['id'] as String,
      seasonId: json['seasonId'] as String,
      leagueId: json['leagueId'] as String,
      number: (json['number'] as num).toInt(),
      name: json['name'] as String,
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$MatchDayToJson(MatchDay instance) => <String, dynamic>{
      'id': instance.id,
      'seasonId': instance.seasonId,
      'leagueId': instance.leagueId,
      'number': instance.number,
      'name': instance.name,
      'isCompleted': instance.isCompleted,
    };
