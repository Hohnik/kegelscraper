// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
      id: json['id'] as String,
      year: (json['year'] as num).toInt(),
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'isCompleted': instance.isCompleted,
    };
