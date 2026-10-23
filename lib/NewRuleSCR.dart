import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pamyatka_for_mind/rule_model.dart';
import 'package:provider/provider.dart';
import 'LocalRulesProvider.dart';
import 'package:vibration/vibration.dart';

class NewRuleScreen extends StatefulWidget {
  const NewRuleScreen({super.key});

  @override
  State<NewRuleScreen> createState() => _NewRuleScreenState();
}

final valdator = (v) =>
    (v == null || v.trim().isEmpty) ? 'Обязательное поле' : null;




const bg = Color(0xFF121212);
const fieldBg = Color(0xFF1C1C1E);
const divider = Color(0xFF2C2C2E);




InputDecoration deco(String label) => InputDecoration(
  labelText: label,
  labelStyle: const TextStyle(color: Colors.white54, fontSize: 14),
  filled: true,

  fillColor: fieldBg,
  isDense: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  ),

  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.white24),
  ),
);

class _NewRuleScreenState extends State<NewRuleScreen> {
  final _formkey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final subjectCtrl = TextEditingController();
  final classCtrl = TextEditingController();
  final descCtrl = TextEditingController();






  bool _validate() {
    final o = _formkey.currentState!.validate();
if(!o){
 
  ScaffoldMessenger.of(context).clearSnackBars();
   ScaffoldMessenger.of(context).
  showSnackBar(
    
  const SnackBar(content: Text('Заполните все поля')),
);
   buzz();}
    return o;
  }





  Future<void> buzz() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 200); // 400 мс
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    subjectCtrl.dispose();
    classCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final ruleProvider = await context.read<LocalRulesProvider>();
    final newRule = rule(
      rule_name: nameCtrl.text.trim(),
      subject: subjectCtrl.text.trim(),
      class_int: int.tryParse(classCtrl.text) ?? 0,
      description: descCtrl.text.trim(),
    );

    await ruleProvider.addRule(newRule);
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white54),
        title: const Text(
          'Новое правило',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(height: 1, color: divider),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formkey,

                  child: Column(
                    children: [
                      TextFormField(
                        validator: valdator,
                        cursorColor: Colors.white,
                        controller: nameCtrl,
                        style: const TextStyle(color: Colors.white),
                        decoration: deco('Название'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        validator: valdator,
                        cursorColor: Colors.white,
                        controller: subjectCtrl,
                        style: const TextStyle(color: Colors.white),
                        decoration: deco('Предмет'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        validator: valdator,

                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        cursorColor: Colors.white,
                        controller: classCtrl,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: deco('Класс(только цифры)'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        validator: valdator,
                        cursorColor: Colors.white,
                        controller: descCtrl,
                        maxLines: 3,
                        style: const TextStyle(color: Colors.white),
                        decoration: deco('Описание'),
                      ),
                      SizedBox(height: size.height * 0.1),

                      FilledButton(
                        onPressed: () async {
                          if (!_validate()) return;
                     
                          await _submit();
                          nameCtrl.clear();
                          classCtrl.clear();
                          descCtrl.clear();
                          subjectCtrl.clear();
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 120,
                            vertical: 20,
                          ),
                        ),
                        child: const Text('Создать'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
