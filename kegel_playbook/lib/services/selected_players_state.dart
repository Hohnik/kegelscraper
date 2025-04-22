import 'package:flutter/material.dart';

import '../repository/api/models/player_game.dart';
import '../repository/api/player_games_api.dart';
import 'enums/match_side.dart';

class SelectedPlayersState {
  late final PlayerGamesApi _playerGamesApi;

  SelectedPlayersState({
    required PlayerGamesApi playerGamesApi,
  }) : _playerGamesApi = playerGamesApi;

  final ValueNotifier<List<PlayerGame>> _homePlayerGames = ValueNotifier([]);
  final ValueNotifier<List<PlayerGame>> _awayPlayerGames = ValueNotifier([]);

  ValueNotifier<List<PlayerGame>> get homePlayerGames => _homePlayerGames;
  ValueNotifier<List<PlayerGame>> get awayPlayerGames => _awayPlayerGames;

  Future<void> getPlayerGames({
    required String playerName,
    required MatchSide matchSide,
  }) async {
    final playerGames = await _playerGamesApi.getPlayerGames(playerName);

    switch (matchSide) {
      case MatchSide.home:
        _setHomePlayerGames(playerGames);
        return;
      case MatchSide.away:
        _setAwayPlayerGames(playerGames);
        return;
    }
  }

  void _setHomePlayerGames(List<PlayerGame> playerGames) {
    _homePlayerGames.value = playerGames;
  }

  void _setAwayPlayerGames(List<PlayerGame> playerGames) {
    _awayPlayerGames.value = playerGames;
  }
}
