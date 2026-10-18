

import 'package:flutter/material.dart';
import 'package:pamyatka_for_mind/LocalRulesProvider.dart';
import 'package:pamyatka_for_mind/rule_model.dart';
import 'package:pamyatka_for_mind/rule_widg.dart';


class RuleFeed extends StatefulWidget {
  const RuleFeed({super.key});

  @override
  State<RuleFeed> createState() => _RuleFeed();
}



class _RuleFeed extends State<RuleFeed> {


final Rule_List = LocalRulesProvider().Rule_List;


Future<void> _showCreateRuleDialog() async {
  final Ruleprovider = LocalRulesProvider();
  final nameCtrl = TextEditingController();
  final subjectCtrl = TextEditingController();
  final classCtrl = TextEditingController();
  final descCtrl = TextEditingController();


  final result = await showDialog<rule>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Новое правило'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Название')),
            TextField(controller: subjectCtrl, decoration: const InputDecoration(labelText: 'Предмет')),
            TextField(
              controller: classCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Класс'),
            ),
            TextField(
              controller: descCtrl,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Описание'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () async {
      
rule NewTempRule;

            Navigator.pop(
              context,
   NewTempRule =  rule(
                rule_name: nameCtrl.text,
                subject: subjectCtrl.text,
                class_int: int.tryParse(classCtrl.text) ?? 0,
                description: descCtrl.text,
              )
              
            );
            setState(() {
              Ruleprovider.AddNewRule(NewTempRule);
            });
          },
          child: const Text('Создать'),
        ),
      ],
    ),
  );

  
}











  @override
  void initState() {
    super.initState();

    _load();
  }


  Future<void> _load() async {
    await LocalRulesProvider().RefreshRuleList();
    if (!mounted) return;
    setState(() {}); // ← вот это заставляет build перезапуститься
  }




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      body: Stack(
        children: [
          SafeArea(
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

          Padding(
            padding: EdgeInsetsGeometry.all(size.width * 0.06),
            child: Align(
              alignment: AlignmentGeometry.bottomRight,
              child: FloatingActionButton(
               
               backgroundColor: Colors.blue,
                onPressed: () {
                 setState(() {
                   _showCreateRuleDialog();
                 });

                },
                child: 
                Icon(Icons.add,color: Colors.white,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
