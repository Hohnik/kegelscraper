import 'package:flutter/material.dart';

class TwoPlayerComparisonSection extends StatelessWidget {
  const TwoPlayerComparisonSection({super.key, 
    required this.title,
    required this.homePlayerWidget,
    required this.awayPlayerWidget,
  });

  final String title;
  final Widget homePlayerWidget;
  final Widget awayPlayerWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                homePlayerWidget,
                awayPlayerWidget,
              ],
            )
          ],
        );
  }
}