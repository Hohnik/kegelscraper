import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

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
            TwoPlayerTotalAverageComparison(
              title: driver.totalAverageTitle,
              homePlayerAverageTotal: driver.homePlayerAverageTotal,
              awayPlayerAverageTotal: driver.awayPlayerAverageTotal,
            ),
            TwoPlayerStandardDeviationComparison(
              title: driver.standardDeviationTitle,
              homePlayerStandardDeviation: driver.homePlayerStandardDeviation,
              awayPlayerStandardDeviation: driver.awayPlayerStandardDeviation,
            ),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<TwoPlayerComparisonViewDriver> get driverProvider => $TwoPlayerComparisonViewDriverProvider();
}
