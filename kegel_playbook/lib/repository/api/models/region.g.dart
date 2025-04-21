// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      id: json['id'] as String,
      tenantId: json['tenantId'] as String,
      countryId: json['countryId'] as String,
      seasonId: json['seasonId'] as String,
      districtId: json['districtId'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'id': instance.id,
      'tenantId': instance.tenantId,
      'countryId': instance.countryId,
      'seasonId': instance.seasonId,
      'districtId': instance.districtId,
      'name': instance.name,
    };
