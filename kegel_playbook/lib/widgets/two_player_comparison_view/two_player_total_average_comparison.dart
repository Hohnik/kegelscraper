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
    return TwoPlayerComparisonSection(
      title: title,
      homePlayerWidget: Text('$homePlayerAverageTotal'),
      awayPlayerWidget: Text('$awayPlayerAverageTotal'),
    );
  }
}
