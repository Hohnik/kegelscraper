import 'package:flutter/material.dart';

import '../repository/api/models/player_game.dart';
import '../repository/api/player_games_api.dart';

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
    required String homePlayerName,
    required String awayPlayerName,
  }) async {
    final homePlayerGames = await _playerGamesApi.getPlayerGames(homePlayerName);
    final awayPlayerGames = await _playerGamesApi.getPlayerGames(awayPlayerName);

    _homePlayerGames.value = homePlayerGames;
    _awayPlayerGames.value = awayPlayerGames;
  }
}
