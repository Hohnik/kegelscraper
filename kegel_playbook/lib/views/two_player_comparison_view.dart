import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../widgets/two_player_comparison_view/two_player_lane_averages_comparison.dart';
import '../widgets/two_player_comparison_view/two_player_names.dart';
import '../widgets/two_player_comparison_view/two_player_on_form_comparison.dart';
import '../widgets/two_player_comparison_view/two_player_standard_deviation_comparison.dart';
import '../widgets/two_player_comparison_view/two_player_total_average_comparison.dart';
import 'two_player_comparison_view_driver.dart';

class TwoPlayerComparisonView extends DrivableWidget<TwoPlayerComparisonViewDriver> {
  TwoPlayerComparisonView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            TwoPlayerNames(
              homePlayerName: driver.homePlayerName,
              awayPlayerName: driver.awayPlayerName,
            ),
            SizedBox(height: 36.0),
            TwoPlayerTotalAverageComparison(
              title: driver.totalAverageTitle,
              homePlayerAverageTotal: driver.homePlayerAverageTotal,
              awayPlayerAverageTotal: driver.awayPlayerAverageTotal,
            ),
            SizedBox(height: 36.0),
            TwoPlayerStandardDeviationComparison(
              title: driver.standardDeviationTitle,
              homePlayerStandardDeviation: driver.homePlayerStandardDeviation,
              awayPlayerStandardDeviation: driver.awayPlayerStandardDeviation,
            ),
            SizedBox(height: 36.0),
            TwoPlayerLaneAveragesComparison(
              title: driver.laneAveragesTitle,
              homePlayerLaneAverages: driver.homePlayerLaneAverages,
              awayPlayerLaneAverages: driver.awayPlayerLaneAverages,
            ),
            SizedBox(height: 36.0),
            TwoPlayerOnFormComparison(
              title: driver.onFormTitle,
              homePlayerOnForm: driver.homePlayerOnForm,
              awayPlayerOnForm: driver.awayPlayerOnForm,
              homePlayerAverageTotal: driver.homePlayerAverageTotal,
              awayPlayerAverageTotal: driver.awayPlayerAverageTotal,
            )
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<TwoPlayerComparisonViewDriver> get driverProvider => $TwoPlayerComparisonViewDriverProvider();
}
