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
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _load();
    });
  }



  Future<bool> _ConfirmDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 45, 45, 45),
          title: Text(
            "Удалить правило?",
            style: const TextStyle(color: Colors.white),
          ),
          content: Text(
            "Вы действительно хотите удалить это правило?",
            style: const TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(
                "отмена",
                style: const TextStyle(
                  color: Color.fromARGB(180, 255, 255, 255),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text(
                "удалить",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }





  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }





  Future<void> _load() async {
    await context.read<LocalRulesProvider>().load();
    if (!mounted) return;
    setState(() {});
  }

  bool _matches(rule rule, String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;

    final dynamic r = rule;
    final parts = <String>[];

    try {
      parts.add('${r.class_int}');
    } catch (_) {}
    try {
      parts.add('${r.description}');
    } catch (_) {}
    try {
      parts.add('${r.subject}');
    } catch (_) {}
    try {
      parts.add('${r.name}');
    } catch (_) {}
    try {
      parts.add('${r.rule_name}');
    } catch (_) {}

    return parts.join(' ').toLowerCase().contains(q);
  }

  @override
  Widget build(BuildContext context) {
    final Rule_List = context.watch<LocalRulesProvider>().rules;
    final provider = context.read<LocalRulesProvider>();
    final size = MediaQuery.of(context).size;

    final filteredRules = _query.trim().isEmpty
        ? Rule_List
        : Rule_List.where((rule) => _matches(rule, _query)).toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                size.width * 0.02,
                size.width * 0.02,
                size.width * 0.02,
                0,
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 0.04,
                ),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Поиск правил...',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(120, 255, 255, 255),
                    fontSize: size.width * 0.04,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color.fromARGB(160, 255, 255, 255),
                  ),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Color.fromARGB(160, 255, 255, 255),
                          ),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 45, 45, 45),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: size.width * 0.03,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(size.width * 0.04),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Rule_List.isEmpty
                  ? Center(
                      child: Text(
                        "У вас не добавлены правила  +",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.width * 0.055,
                          fontWeight: FontWeight.w800,
                          color: const Color.fromARGB(160, 255, 255, 255),
                        ),
                      ),
                    )
                  : filteredRules.isEmpty
                  ? Center(
                      child: Text(
                        "Ничего не найдено",
                        style: TextStyle(
                          fontSize: size.width * 0.055,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(160, 255, 255, 255),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(size.width * 0.02),
                      child: ListView.builder(
                        itemCount: filteredRules.length,
                        itemBuilder: (context, index) {
                          return RuleWidg(
                            Rule_model: filteredRules[index],
                            onTap: () async {

                         
                              final iss = await _ConfirmDialog(context);

                              if (!iss) return;

                           provider.removeRule(Rule_List[index]);
                            },
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
