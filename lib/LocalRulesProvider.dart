import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:pamyatka_for_mind/rule_model.dart';

class LocalRulesProvider with ChangeNotifier {
  static const _key = 'rule_string';
  static const _backupPrefix = 'rule_string_corrupted_';

  List<rule> rules = [];
  bool _disposed = false;
  bool _isLoading = false;
  Object? _error;
  Future<void> _writeQueue = Future.value();

  bool get isLoading => _isLoading;
  Object? get error => _error;








void removeRule(rule rule) async {
  rules.removeWhere((r) => r.rule_name == rule.rule_name); 
  
_safeNotify();
 await ListSave();
}





  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void _safeNotify() {
    if (!_disposed) notifyListeners();
  }





  Future<void> load() async {
    _isLoading = true;
    _error = null;
    _safeNotify();
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw == null || raw.isEmpty) {
        rules = [];
        return;
      }

      final decoded = jsonDecode(raw);
      
      if (decoded is! List) throw const FormatException('not a list');
      rules = decoded
          .whereType<Map<String, dynamic>>()
          .map(rule.fromJson)
          .toList();
    } catch (e, st) {
      _error = e;
      debugPrint('load rules failed: $e\n$st');
      rules = [];
    
      try {
        final prefs = await SharedPreferences.getInstance();
        final raw = prefs.getString(_key);
        if (raw != null) {
          await prefs.setString(
            '$_backupPrefix${DateTime.now().millisecondsSinceEpoch}',
            raw,
          );
          await prefs.remove(_key);
        }
      } catch (_) {}
    } finally {
      _isLoading = false;
      _safeNotify();
    }
  }




  Future<void> addRule(rule NewRule) async {
    final prefs = await SharedPreferences.getInstance();

    final gjse = await prefs.getString(_key);

final UnjsonD;

   if (gjse != null) {

     UnjsonD = (jsonDecode(gjse!) as List)
        .map((e) => rule.fromJson(e as Map<String, dynamic>))
        .toList();
} else {
UnjsonD = [];
}

    UnjsonD.add(NewRule);

    String newJs = jsonEncode(UnjsonD.map((rule) => rule.toJson()).toList());

    final r = await prefs.setString(_key, newJs);
    

    _safeNotify();
    load();
  }
  

 Future<void> ListSave() async {
    final prefs = await SharedPreferences.getInstance();

   



  

  

    String newJs = jsonEncode(rules.map((rule) => rule.toJson()).toList());

    final r = await prefs.setString(_key, newJs);
    

    _safeNotify();
    load();
  }
  
  
}
