import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pamyatka_for_mind/rule_model.dart';
import 'package:pamyatka_for_mind/rule_widg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RuleFeed extends StatefulWidget {
  const RuleFeed({super.key});

  @override
  State<RuleFeed> createState() => _RuleFeed();
}

List<rule> Rule_Model_List = [];



Future<void> GetRuleList() async {
  final shared = await SharedPreferences.getInstance();


final ms = rule(description: "test", class_int: 1, rule_name: "testr", subject: "oio").toJson();
final jsonStr = jsonEncode(ms);


await shared.setString("rule_string", jsonStr);


  await Future.delayed(const Duration(seconds: 2)); 

  String JsonRuleString = shared.getString("rule_string").toString();
 if (JsonRuleString.isEmpty || JsonRuleString == null) {
  return;
 }




final GetedList = (jsonDecode(JsonRuleString) as List)
    .map((e) => rule.fromJson(e as Map<String, dynamic>))
    .toList();

Rule_Model_List = GetedList;
}



class _RuleFeed extends State<RuleFeed> {
   @override
  void initState() {
    super.initState();
    GetRuleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      body: SafeArea(
        child: ListView.builder(
          itemCount: Rule_Model_List.length,
          itemBuilder: (context, index) {
            return RuleWidg(
              Rule_model: rule(
                description: " корня лаж или лог - не существует".toLowerCase(),
                class_int: 8,
                rule_name: "ЛАГ-ЛОЖ".toLowerCase(),
                subject: "Русский",
              ),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
