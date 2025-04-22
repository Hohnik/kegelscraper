import 'package:flutter/material.dart';

import 'services/service_locator.dart';
import 'views/two_player_comparison_view.dart';

void main() {
  setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kegel Playbook',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: KegelPlaybook(),
    );
  }
}

class KegelPlaybook extends StatelessWidget {
  const KegelPlaybook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: TwoPlayerComparisonView(),
    );
  }
}
