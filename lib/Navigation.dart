import 'package:flutter/material.dart';
import 'package:pamyatka_for_mind/NewRuleSCR.dart';
import 'package:pamyatka_for_mind/rule_feed.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

int currentScr = 0;

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        IndexedStack(index: currentScr, children: [RuleFeed(), NewRuleScreen()]),

        Padding(
          padding: EdgeInsetsGeometry.only(
            bottom: size.height * 0.026,
            right: size.width * 0.05,
          ),
          child: Align(
            alignment: AlignmentGeometry.bottomRight,
            child: Container(
              width: size.width * 0.4,
              height: size.height / 12,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(80),
              ),

              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        currentScr = 0;
                        setState(() {});
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blueAccent.shade700,
                        radius: size.width * 0.075,
                        child: Icon(
                          Icons.list,
                          color: Colors.white,
                          size: size.width * 0.07,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        currentScr = 1;
                        setState(() {});
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blueAccent.shade700,
                        radius: size.width * 0.075,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: size.width * 0.08,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
