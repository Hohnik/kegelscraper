import 'package:json_annotation/json_annotation.dart';

part 'player_game.g.dart';

@JsonSerializable()
class PlayerGame {
  final String id;
  final String name;
  final int lane1;
  final int lane2;
  final int lane3;
  final int lane4;
  final int total;
  final double sets;
  final double points;
  final String matchId;

  PlayerGame({
    required this.id,
    required this.name,
    required this.lane1,
    required this.lane2,
    required this.lane3,
    required this.lane4,
    required this.total,
    required this.sets,
    required this.points,
    required this.matchId,
  });

  factory PlayerGame.fromJson(Map<String, dynamic> json) => _$PlayerGameFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerGameToJson(this);
}
