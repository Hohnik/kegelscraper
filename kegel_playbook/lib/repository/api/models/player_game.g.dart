// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerGame _$PlayerGameFromJson(Map<String, dynamic> json) => PlayerGame(
      id: json['id'] as String,
      name: json['name'] as String,
      lane1: (json['lane1'] as num).toInt(),
      lane2: (json['lane2'] as num).toInt(),
      lane3: (json['lane3'] as num).toInt(),
      lane4: (json['lane4'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      sets: (json['sets'] as num).toDouble(),
      points: (json['points'] as num).toDouble(),
      matchId: json['matchId'] as String,
    );

Map<String, dynamic> _$PlayerGameToJson(PlayerGame instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lane1': instance.lane1,
      'lane2': instance.lane2,
      'lane3': instance.lane3,
      'lane4': instance.lane4,
      'total': instance.total,
      'sets': instance.sets,
      'points': instance.points,
      'matchId': instance.matchId,
    };
