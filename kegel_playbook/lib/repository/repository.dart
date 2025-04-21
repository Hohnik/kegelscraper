import 'api/api.dart';
import 'api/models/player_game.dart';

class Repository {
  final _api = Api();

  Future<List<PlayerGame>?> getPlayerGames(String playerId) async {
    try {
      return await _api.getPlayerGames(playerId);
    } catch (e) {
      // Log the error if needed
      print('Error fetching player games: $e');
      return null;
    }
  }
}
