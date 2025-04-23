import 'package:flutter/material.dart';

import 'two_player_comparison_section.dart';

class TwoPlayerOnFormComparison extends StatelessWidget {
  const TwoPlayerOnFormComparison({
    super.key,
    required this.title,
    required this.homePlayerOnForm,
    required this.awayPlayerOnForm,
    required this.homePlayerAverageTotal,
    required this.awayPlayerAverageTotal,
  });

  final String title;
  final double? homePlayerOnForm;
  final double? awayPlayerOnForm;
  final double homePlayerAverageTotal;
  final double awayPlayerAverageTotal;

  String _getFormText(double? onFormValue) {
    if (onFormValue == null) return 'On average';
    if (onFormValue > 0) return 'On form (+${onFormValue.toStringAsFixed(2)})';
    return 'Not on form (${onFormValue.toStringAsFixed(2)})';
  }

  @override
  Widget build(BuildContext context) {
    final homePlayerAdvantage =
        homePlayerAverageTotal + (homePlayerOnForm ?? 0) > awayPlayerAverageTotal + (awayPlayerOnForm ?? 0);
    final homePlayerTextStyle = TextStyle(color: homePlayerAdvantage ? Colors.green : Colors.black);
    final awayPlayerTextStyle = TextStyle(color: homePlayerAdvantage ? Colors.black : Colors.green);

    return TwoPlayerComparisonSection(
      title: title,
      homePlayerWidget: Text(_getFormText(homePlayerOnForm), style: homePlayerTextStyle),
      awayPlayerWidget: Text(_getFormText(awayPlayerOnForm), style: awayPlayerTextStyle),
    );
  }
}
