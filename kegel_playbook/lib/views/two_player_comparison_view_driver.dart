import 'dart:math';

import 'package:widget_driver/widget_driver.dart';

import '../repository/api/models/player_game.dart';
import '../services/selected_players_state.dart';
import '../services/service_locator.dart';
import '../utils/calc_average.dart';

part 'two_player_comparison_view_driver.g.dart';

@GenerateTestDriver()
class TwoPlayerComparisonViewDriver extends WidgetDriver {
  final _selectedPlayersState = getIt.get<SelectedPlayersState>();

  TwoPlayerComparisonViewDriver();

  List<PlayerGame> _homePlayerGames = [];
  List<PlayerGame> _awayPlayerGames = [];

  String get totalAverageTitle => 'Total average';
  String get standardDeviationTitle => 'Standard deviation';
  String get laneAveragesTitle => 'Lane averages';
  String get onFormTitle => 'On form';

  String get homePlayerName => _homePlayerGames.isNotEmpty ? _homePlayerGames.first.name : '';
  String get awayPlayerName => _awayPlayerGames.isNotEmpty ? _awayPlayerGames.first.name : '';

  double get homePlayerStandardDeviation => _calculateStandardDeviation(_homePlayerGames);
  double get awayPlayerStandardDeviation => _calculateStandardDeviation(_awayPlayerGames);

  double get homePlayerAverageTotal => calcAverage(_homePlayerGames.map((game) => game.total).toList());
  double get awayPlayerAverageTotal => calcAverage(_awayPlayerGames.map((game) => game.total).toList());

  List<double> get homePlayerLaneAverages => [
        calcAverage(_homePlayerGames.map((game) => game.lane1).toList()),
        calcAverage(_homePlayerGames.map((game) => game.lane2).toList()),
        calcAverage(_homePlayerGames.map((game) => game.lane3).toList()),
        calcAverage(_homePlayerGames.map((game) => game.lane4).toList()),
      ];

  List<double> get awayPlayerLaneAverages => [
        calcAverage(_awayPlayerGames.map((game) => game.lane1).toList()),
        calcAverage(_awayPlayerGames.map((game) => game.lane2).toList()),
        calcAverage(_awayPlayerGames.map((game) => game.lane3).toList()),
        calcAverage(_awayPlayerGames.map((game) => game.lane4).toList()),
      ];

  double? get homePlayerOnForm => _calculateOnForm(_homePlayerGames);
  double? get awayPlayerOnForm => _calculateOnForm(_awayPlayerGames);

  double? _calculateOnForm(List<PlayerGame> games) {
    if (games.length < 3) return null;

    final totalAverage = calcAverage(games.map((game) => game.total).toList());
    final lastThreeGames = games.sublist(games.length - 3);
    final lastThreeAverage = calcAverage(lastThreeGames.map((game) => game.total).toList());
    final difference = lastThreeAverage - totalAverage;

    if (difference.abs() <= 5) return null;
    return difference;
  }

  double _calculateStandardDeviation(List<PlayerGame> games) {
    final values = games.map((game) => game.total).toList();
    final mean = calcAverage(values);

    final squaredDifferences = values.map((value) {
      final difference = value - mean;
      return difference * difference;
    }).toList();

    final variance = calcAverage(squaredDifferences);
    return sqrt(variance).ceilToDouble();
  }

  void _onHomePlayerGamesChange() {
    _homePlayerGames = _selectedPlayersState.homePlayerGames.value;
    notifyWidget();
  }

  void _onAwayPlayerGamesChange() {
    _awayPlayerGames = _selectedPlayersState.awayPlayerGames.value;
    notifyWidget();
  }

  @override
  void didInitDriver() {
    super.didInitDriver();

    _homePlayerGames = _selectedPlayersState.homePlayerGames.value;
    _awayPlayerGames = _selectedPlayersState.awayPlayerGames.value;

    _selectedPlayersState.homePlayerGames.addListener(_onHomePlayerGamesChange);
    _selectedPlayersState.awayPlayerGames.addListener(_onAwayPlayerGamesChange);

    _selectedPlayersState.getPlayerGames(
      homePlayerName: 'Felix Hohn',
      awayPlayerName: 'Jane Smith',
    );
  }
}
