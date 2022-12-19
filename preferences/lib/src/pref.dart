import 'package:shared_preferences/shared_preferences.dart';

class BoolPref extends Pref<bool> {
  BoolPref(String key, [bool? defaultValue]) : super(key, _setValue, defaultValue);
  BoolPref.defaultFalse(String key) : super(key, _setValue, false);
  BoolPref.defaultTrue(String key) : super(key, _setValue, true);
  static Future<bool> _setValue(SharedPreferences sharedPreferences, String key, bool value) {
    return sharedPreferences.setBool(key, value);
  }
}

class DoublePref extends Pref<double> {
  DoublePref(String key, [double? defaultValue]) : super(key, _setValue, defaultValue);
  static Future<bool> _setValue(SharedPreferences sharedPreferences, String key, double value) {
    return sharedPreferences.setDouble(key, value);
  }
}

class IntPref extends Pref<int> {
  IntPref(String key, [int? defaultValue]) : super(key, _setValue, defaultValue);
  static Future<bool> _setValue(SharedPreferences sharedPreferences, String key, int value) {
    return sharedPreferences.setInt(key, value);
  }
}

class StringPref extends Pref<String> {
  StringPref(String key, [String? defaultValue]) : super(key, _setValue, defaultValue);
  static Future<bool> _setValue(SharedPreferences sharedPreferences, String key, String value) {
    return sharedPreferences.setString(key, value);
  }
}

class StringListPref extends Pref<List<String>> {
  StringListPref(String key, [List<String>? defaultValue]) : super(key, _setValue, defaultValue);
  static Future<bool> _setValue(
      SharedPreferences sharedPreferences, String key, List<String> value) {
    return sharedPreferences.setStringList(key, value);
  }
}

abstract class Pref<T extends Object?> {
  Pref(this.key, this.setterMethod, [this.defaultValue]);

  final String key;
  final T? defaultValue;
  final Future<bool> Function(SharedPreferences sharedPreferences, String key, T value)
      setterMethod;

  Future<T?> get() async {
    final instance = await SharedPreferences.getInstance();
    var value = instance.get(key);
    if (value == null && defaultValue != null) {
      value = defaultValue;
    }
    return value as T?;
  }

  Future<String?> getFormatted(String? Function(T? value)? formatter) async {
    final result = await get();
    if (formatter == null) return result.toString();
    return formatter.call(result);
  }

  Future<bool> set(T value) async {
    final instance = await SharedPreferences.getInstance();
    return await setterMethod.call(instance, key, value);
  }
}

// Future<T?> getPref<T extends Object?>(Pref<T> pref) async {
//   final instance = await SharedPreferences.getInstance();
//   var value = instance.get(pref.key);
//   if (value == null && pref.defaultValue != null) {
//     value = pref.defaultValue;
//   }
//   return value as T?;
// }
