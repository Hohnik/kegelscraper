import 'models/player_game.dart';

class Api {
  Future<List<PlayerGame>> getPlayerGames(String playerId) async {
    // Mock data - in a real implementation, this would fetch from Supabase
    if (playerId == '1') {
      return [
        PlayerGame(
          id: '1',
          name: 'John Doe',
          matchId: '1',
          lane1: 180,
          lane2: 165,
          lane3: 190,
          lane4: 175,
          total: 710,
          sets: 2,
          points: 1.0,
        ),
        PlayerGame(
          id: '2',
          name: 'John Doe',
          matchId: '2',
          lane1: 170,
          lane2: 185,
          lane3: 160,
          lane4: 195,
          total: 710,
          sets: 1,
          points: 0.5,
        ),
        PlayerGame(
          id: '3',
          name: 'John Doe',
          matchId: '3',
          lane1: 160,
          lane2: 175,
          lane3: 180,
          lane4: 170,
          total: 685,
          sets: 0,
          points: 0.0,
        ),
        PlayerGame(
          id: '4',
          name: 'John Doe',
          matchId: '4',
          lane1: 190,
          lane2: 165,
          lane3: 175,
          lane4: 180,
          total: 710,
          sets: 2,
          points: 1.0,
        ),
      ];
    } else {
      return [
        PlayerGame(
          id: '1',
          name: 'Jane Smith',
          matchId: '1',
          lane1: 190,
          lane2: 195,
          lane3: 185,
          lane4: 200,
          total: 770,
          sets: 2,
          points: 1.0,
        ),
        PlayerGame(
          id: '2',
          name: 'Jane Smith',
          matchId: '2',
          lane1: 175,
          lane2: 180,
          lane3: 170,
          lane4: 185,
          total: 710,
          sets: 2,
          points: 1.0,
        ),
        PlayerGame(
          id: '3',
          name: 'Jane Smith',
          matchId: '3',
          lane1: 165,
          lane2: 170,
          lane3: 175,
          lane4: 180,
          total: 690,
          sets: 1,
          points: 0.5,
        ),
        PlayerGame(
          id: '4',
          name: 'Jane Smith',
          matchId: '4',
          lane1: 180,
          lane2: 185,
          lane3: 190,
          lane4: 195,
          total: 750,
          sets: 2,
          points: 1.0,
        ),
      ];
    }
  }
}
