import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoolPref extends Pref<bool> {
  BoolPref(super.key, [super.defaultValue]);
}

class DoublePref extends Pref<double> {
  DoublePref(super.key, [super.defaultValue]);
}

class IntPref extends Pref<int> {
  IntPref(super.key, [super.defaultValue]);
}

class StringPref extends Pref<String> {
  StringPref(super.key, [super.defaultValue]);
}

class StringListPref extends Pref<List<String>> {
  StringListPref(super.key, [super.defaultValue]);
}

abstract class Pref<T extends Object?> {
  Pref(this.key, [this.defaultValue]);

  final String key;
  final T? defaultValue;

  Future<T?> get() async {
    return await getPref(this);
  }

  Future<String?> getFormatted(String? Function(T? value) formatter) async {
    final result = await get();
    return formatter.call(result);
  }
}

Future<T?> getPref<T extends Object?>(Pref<T> pref) async {
  final instance = await SharedPreferences.getInstance();
  var value = instance.get(pref.key);
  if (value == null && pref.defaultValue != null) {
    value = pref.defaultValue;
  }
  return value as T?;
}
