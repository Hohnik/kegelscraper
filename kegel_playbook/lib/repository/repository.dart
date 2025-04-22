import 'api/player_games_api.dart';
import 'api/models/player_game.dart';

class Repository {
  final _playerGamesApi = PlayerGamesApi();

  Future<List<PlayerGame>?> getPlayerGames(String playerId) async {
    try {
      return await _playerGamesApi.getPlayerGames(playerId);
    } catch (e) {
      // Log the error if needed
      print('Error fetching player games: $e');
      return null;
    }
  }
}
