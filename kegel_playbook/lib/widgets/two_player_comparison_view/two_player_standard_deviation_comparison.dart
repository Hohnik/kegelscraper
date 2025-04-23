import 'package:flutter/material.dart';

import 'two_player_comparison_section.dart';

class TwoPlayerStandardDeviationComparison extends StatelessWidget {
  const TwoPlayerStandardDeviationComparison({
    super.key,
    required this.title,
    required this.homePlayerStandardDeviation,
    required this.awayPlayerStandardDeviation,
  });

  final String title;
  final double homePlayerStandardDeviation;
  final double awayPlayerStandardDeviation;

  @override
  Widget build(BuildContext context) {
    final homePlayerAdvantage = homePlayerStandardDeviation < awayPlayerStandardDeviation;
    final homePlayerTextStyle = TextStyle(color: homePlayerAdvantage ? Colors.green : Colors.black);
    final awayPlayerTextStyle = TextStyle(color: homePlayerAdvantage ? Colors.black : Colors.green);

    return TwoPlayerComparisonSection(
      title: title,
      homePlayerWidget: Text(
        homePlayerStandardDeviation.toStringAsFixed(2),
        style: homePlayerTextStyle,
      ),
      awayPlayerWidget: Text(
        awayPlayerStandardDeviation.toStringAsFixed(2),
        style: awayPlayerTextStyle,
      ),
    );
  }
}
