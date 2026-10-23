import 'package:flutter/material.dart';
import 'package:pamyatka_for_mind/NewRuleSCR.dart';
import 'package:pamyatka_for_mind/rule_feed.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _HomeShellState();
}

class _HomeShellState extends State<Navigation> {
  int _index = 0;

  final _pages = const [
    RuleFeed(),
    NewRuleScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        backgroundColor: const Color.fromARGB(255, 45, 45, 45),
        indicatorColor: const Color.fromARGB(60, 255, 255, 255),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list, color: Colors.white70),
            selectedIcon: Icon(Icons.list, color: Colors.white),
            label: 'Лента',
          ),
          NavigationDestination(
            icon: Icon(Icons.add, color: Colors.white70),
            selectedIcon: Icon(Icons.add, color: Colors.white),
            label: 'Добавить',
          ),
        ],
      ),
    );
  }
}