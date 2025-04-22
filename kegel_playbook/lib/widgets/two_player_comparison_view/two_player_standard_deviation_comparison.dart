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
    return TwoPlayerComparisonSection(
      title: title,
      homePlayerWidget: Text('$homePlayerStandardDeviation'),
      awayPlayerWidget: Text('$awayPlayerStandardDeviation'),
    );
  }
}
