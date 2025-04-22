import 'package:widget_driver/widget_driver.dart';

import '../repository/api/models/player_game.dart';
import '../services/selected_players_state.dart';
import '../services/service_locator.dart';

part 'two_player_comparison_view_driver.g.dart';

@GenerateTestDriver()
class TwoPlayerComparisonViewDriver extends WidgetDriver {
  final _selectedPlayersState = getIt.get<SelectedPlayersState>();

  TwoPlayerComparisonViewDriver();

  late List<PlayerGame> _homePlayerGames;
  late List<PlayerGame> _awayPlayerGames;

  void _onHomePlayerGamesChange() {
    _homePlayerGames = _selectedPlayersState.homePlayerGames.value;
  }

  void _onAwayPlayerGamesChange() {
    _awayPlayerGames = _selectedPlayersState.awayPlayerGames.value;
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _homePlayerGames = _selectedPlayersState.homePlayerGames.value;
    _awayPlayerGames = _selectedPlayersState.awayPlayerGames.value;
    _selectedPlayersState.homePlayerGames.addListener(_onHomePlayerGamesChange);
    _selectedPlayersState.awayPlayerGames.addListener(_onAwayPlayerGamesChange);
  }
}
