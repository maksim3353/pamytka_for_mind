import 'package:flutter/material.dart';
import 'package:pamyatka_for_mind/Info.dart';
import 'package:pamyatka_for_mind/NewRuleSCR.dart';
import 'package:pamyatka_for_mind/rule_feed.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _HomeShellState();
}

class _HomeShellState extends State<Navigation> {
  int _index = 0;

  final pages = const [RuleFeed(), NewRuleScreen(),InfoScr()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      body: IndexedStack(index: _index, children: pages),



      bottomNavigationBar: NavigationBar(

          labelTextStyle: WidgetStatePropertyAll(
      TextStyle(color: Colors.white, fontSize: 12),
    ),
  

        surfaceTintColor: const Color.fromARGB(255, 0, 0, 0),

        selectedIndex: _index,

        onDestinationSelected: (i) => setState(() => _index = i),

        backgroundColor: const Color.fromARGB(255, 44, 44, 44),

        indicatorColor: const Color.fromARGB(250, 255, 255, 255),

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list, color: Colors.white),
            selectedIcon: Icon(Icons.list, color: Color.fromARGB(255, 0, 0, 0)),
            label: 'Лента',
            
          ),
          NavigationDestination(
            icon: Icon(Icons.add, color: Colors.white),
            selectedIcon: Icon(Icons.add, color: Color.fromARGB(255, 0, 0, 0)),
            label: 'Добавить',
          ),
          NavigationDestination(
            icon: Icon(Icons.info, color: Colors.white),
            selectedIcon: Icon(Icons.add, color: Color.fromARGB(255, 0, 0, 0)),
            label: 'Полезное',
          ),
        ],
      ),
    );
  }
}
