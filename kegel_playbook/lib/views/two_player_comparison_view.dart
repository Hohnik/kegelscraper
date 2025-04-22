import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'two_player_comparison_view_driver.dart';

class TwoPlayerComparisonView extends DrivableWidget<TwoPlayerComparisonViewDriver> {
  TwoPlayerComparisonView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  WidgetDriverProvider<TwoPlayerComparisonViewDriver> get driverProvider => $TwoPlayerComparisonViewDriverProvider();
}
