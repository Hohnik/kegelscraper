import 'package:flutter/material.dart';

class TwoPlayerNames extends StatelessWidget {
  const TwoPlayerNames({
    super.key,
    required this.homePlayerName,
    required this.awayPlayerName,
  });

  final String homePlayerName;
  final String awayPlayerName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(homePlayerName),
        Text(awayPlayerName),
      ],
    );
  }
}
