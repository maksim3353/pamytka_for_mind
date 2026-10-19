

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






Future<void> _showCreateRuleDialog(BuildContext context) async {
  final ruleProvider = context.read<LocalRulesProvider>();

  final nameCtrl = TextEditingController();
  final subjectCtrl = TextEditingController();
  final classCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  const bg = Color(0xFF121212);
  const fieldBg = Color(0xFF1C1C1E);
  const divider = Color(0xFF2C2C2E);

  InputDecoration deco(String label) => InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54, fontSize: 14),
        filled: true,
        fillColor: fieldBg,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white24),
        ),
      );

  await showDialog<void>(
    context: context,
    builder: (dialogContext) {
      final height = MediaQuery.of(dialogContext).size.height;
      return Dialog(
        backgroundColor: bg,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 480,
            maxHeight: height * 0.85,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 12, 8),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Новое правило',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      icon: const Icon(Icons.close, size: 20),
                      color: Colors.white54,
                      splashRadius: 20,
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: divider),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: nameCtrl,
                        style: const TextStyle(color: Colors.white),
                        decoration: deco('Название'),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: subjectCtrl,
                        style: const TextStyle(color: Colors.white),
                        decoration: deco('Предмет'),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: classCtrl,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: deco('Класс'),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: descCtrl,
                        maxLines: 3,
                        style: const TextStyle(color: Colors.white),
                        decoration: deco('Описание'),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1, color: divider),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white70,
                      ),
                      child: const Text('Отмена'),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () async {
                        final newRule = rule(
                          rule_name: nameCtrl.text.trim(),
                          subject: subjectCtrl.text.trim(),
                          class_int: int.tryParse(classCtrl.text) ?? 0,
                          description: descCtrl.text.trim(),
                        );
                        await ruleProvider.AddNewRule(newRule);
                        if (dialogContext.mounted) {
                          Navigator.of(dialogContext).pop();
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      child: const Text('Создать'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );


}








  @override
  void initState() {
    super.initState();
WidgetsBinding.instance.addPostFrameCallback((_){

   _load();
});
   
  }


  Future<void> _load() async {
    await context.read<LocalRulesProvider>().RefreshRuleList();
 
    setState(() {}); // ← вот это заставляет build перезапуститься
  }




  @override
  Widget build(BuildContext context) {
    
final Rule_List = context.watch<LocalRulesProvider>().Rule_List;
    final size = MediaQuery.of(context).size;




    return 
  
    
    Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      body:
      
     

       Stack(
        children: [
           Rule_List.isEmpty? 

Center(child:  Text( 
                    //subject
                 
                    "У вас не добавлены правила - +",
                    style: TextStyle(
                      fontSize: size.width * 0.055,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(160, 255, 255, 255),
                    ),
                  ),) :
          SafeArea(
            child: Padding(padding: EdgeInsetsGeometry.all(size.width *0.02),child:  ListView.builder(
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

          Padding(
            padding: EdgeInsetsGeometry.all(size.width * 0.06),
            child: Align(
              alignment: AlignmentGeometry.bottomRight,
              child: FloatingActionButton(
               
               backgroundColor: Colors.blue,
                onPressed: () => _showCreateRuleDialog(context),
                

             
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
