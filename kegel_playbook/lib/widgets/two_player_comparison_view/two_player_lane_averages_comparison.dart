import 'package:flutter/material.dart';

import 'two_player_comparison_section.dart';

class TwoPlayerLaneAveragesComparison extends StatelessWidget {
  const TwoPlayerLaneAveragesComparison({
    super.key,
    required this.title,
    required this.homePlayerLaneAverages,
    required this.awayPlayerLaneAverages,
  });

  final String title;
  final List<double> homePlayerLaneAverages;
  final List<double> awayPlayerLaneAverages;

  @override
  Widget build(BuildContext context) {
    final homePlayerAdvantages = [];

    for (var i = 0; i < homePlayerLaneAverages.length; i++) {
      final homePlayerAdvantage = homePlayerLaneAverages[i] > awayPlayerLaneAverages[i];
      homePlayerAdvantages.add(homePlayerAdvantage);
    }

    return TwoPlayerComparisonSection(
      title: title,
      homePlayerWidget: Column(
        children: List.generate(homePlayerLaneAverages.length, (index) {
          final homePlayerAdvantage = homePlayerAdvantages[index];
          final homePlayerTextStyle = TextStyle(color: homePlayerAdvantage ? Colors.green : Colors.black);

          return Text(
            homePlayerLaneAverages[index].toStringAsFixed(2),
            style: homePlayerTextStyle,
          );
        }),
      ),
      awayPlayerWidget: Column(
        children: List.generate(awayPlayerLaneAverages.length, (index) {
          final homePlayerAdvantage = homePlayerAdvantages[index];
          final awayPlayerTextStyle = TextStyle(color: homePlayerAdvantage ? Colors.black : Colors.green);

          return Text(
            awayPlayerLaneAverages[index].toStringAsFixed(2),
            style: awayPlayerTextStyle,
          );
        }),
      ),
    );
  }
}
