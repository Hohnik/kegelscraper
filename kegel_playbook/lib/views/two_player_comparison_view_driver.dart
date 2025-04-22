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

  double get homePlayerStandardDeviation => _calculateStandardDeviation(_homePlayerGames);
  double get awayPlayerStandardDeviation => _calculateStandardDeviation(_awayPlayerGames);

  double get homePlayerAverageTotal => calcAverage(_homePlayerGames.map((game) => game.total).toList());
  double get awayPlayerAverageTotal => calcAverage(_awayPlayerGames.map((game) => game.total).toList());

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
      homePlayerName: 'John Doe',
      awayPlayerName: 'Jane Smith',
    );
  }
}
