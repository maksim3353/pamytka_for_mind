import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pamyatka_for_mind/LocalRulesProvider.dart';
import 'package:pamyatka_for_mind/rule_model.dart';
import 'package:pamyatka_for_mind/rule_widg.dart';
import 'package:provider/provider.dart';

class RuleFeed extends StatefulWidget {
  const RuleFeed({super.key});

  @override
  State<RuleFeed> createState() => _RuleFeed();
}

class _RuleFeed extends State<RuleFeed> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _load();
    });
  }

  Future<void> _load() async {
    await context.read<LocalRulesProvider>().load();

    setState(() {}); // ← вот это заставляет build перезапуститься
  }

  @override
  Widget build(BuildContext context) {
    final Rule_List = context.watch<LocalRulesProvider>().rules;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      body: Stack(
        children: [
          Rule_List.isEmpty
              ? Center(
                  child: Text(
                    //subject
                    "У вас не добавлены правила - +",
                    style: TextStyle(
                      fontSize: size.width * 0.055,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(160, 255, 255, 255),
                    ),
                  ),
                )
              : SafeArea(
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(size.width * 0.02),
                    child: ListView.builder(
                      itemCount: Rule_List.length,
                      itemBuilder: (context, index) {
                        return RuleWidg(
                          Rule_model: Rule_List[index],
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
