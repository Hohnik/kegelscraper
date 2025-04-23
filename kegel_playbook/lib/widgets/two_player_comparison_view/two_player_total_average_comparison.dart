import 'package:flutter/material.dart';

import 'two_player_comparison_section.dart';

class TwoPlayerTotalAverageComparison extends StatelessWidget {
  const TwoPlayerTotalAverageComparison({
    super.key,
    required this.title,
    required this.homePlayerAverageTotal,
    required this.awayPlayerAverageTotal,
  });

  final String title;
  final double homePlayerAverageTotal;
  final double awayPlayerAverageTotal;

  @override
  Widget build(BuildContext context) {
    final homePlayerAdvantage = homePlayerAverageTotal > awayPlayerAverageTotal;
    final homePlayerTextStyle = TextStyle(color: homePlayerAdvantage ? Colors.green : Colors.black);
    final awayPlayerTextStyle = TextStyle(color: homePlayerAdvantage ? Colors.black : Colors.green);

    return TwoPlayerComparisonSection(
      title: title,
      homePlayerWidget: Text(
        homePlayerAverageTotal.toStringAsFixed(2),
        style: homePlayerTextStyle,
      ),
      awayPlayerWidget: Text(
        awayPlayerAverageTotal.toStringAsFixed(2),
        style: awayPlayerTextStyle,
      ),
    );
  }
}
