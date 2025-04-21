// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

League _$LeagueFromJson(Map<String, dynamic> json) => League(
      id: json['id'] as String,
      seasonId: json['seasonId'] as String,
      districtId: json['districtId'] as String,
      regionId: json['regionId'] as String,
      name: json['name'] as String,
      isActive: json['isActive'] as bool,
      leagueManager: json['leagueManager'] as String,
      phone1: json['phone1'] as String?,
      phone2: json['phone2'] as String?,
      phone3: json['phone3'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$LeagueToJson(League instance) => <String, dynamic>{
      'id': instance.id,
      'seasonId': instance.seasonId,
      'districtId': instance.districtId,
      'regionId': instance.regionId,
      'name': instance.name,
      'isActive': instance.isActive,
      'leagueManager': instance.leagueManager,
      'phone1': instance.phone1,
      'phone2': instance.phone2,
      'phone3': instance.phone3,
      'email': instance.email,
    };
