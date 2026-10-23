import 'package:flutter/material.dart';
import 'package:pamyatka_for_mind/LocalRulesProvider.dart';
import 'package:pamyatka_for_mind/Navigation.dart';
import 'package:pamyatka_for_mind/rule_feed.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LocalRulesProvider())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigation());
  }
}
