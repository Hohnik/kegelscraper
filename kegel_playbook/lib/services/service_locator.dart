import 'package:get_it/get_it.dart';

import '../repository/api/player_games_api.dart';
import 'selected_players_state.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  final playerGamesApi = PlayerGamesApi();

  getIt.registerLazySingleton<SelectedPlayersState>(
    () => SelectedPlayersState(playerGamesApi: playerGamesApi),
  );
}
