
import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferencesDataBase{

  final SharedPreferences instance;
  const LocalPreferencesDataBase({required this.instance});

  Future<void> saveValue<T>(String key, T value) async {
    switch (T) {
      case const (int):
        await instance.setInt(key, value as int);
      case const (double):
        await instance.setDouble(key, value as double);
      case const (String):
        await instance.setString(key, value as String);
      case const (bool):
        await instance.setBool(key, value as bool);
      case const (List<String>):
        await instance.setStringList(key, value as List<String>);
      default:
        throw ArgumentError('Type ${T.toString()} not supported');
    }
  }

  T? getValue<T>(String key, T? defaultValue) {
    try {
      switch (T) {
        case const (int):
          return instance.getInt(key) as T? ?? defaultValue;
        case const (double):
          return instance.getDouble(key) as T? ?? defaultValue;
        case const (String):
          return instance.getString(key) as T? ?? defaultValue;
        case const (bool):
          return instance.getBool(key) as T? ?? defaultValue;
        case const (List<String>):
          return instance.getStringList(key) as T? ?? defaultValue;
        default:
          throw ArgumentError('Type ${T.toString()} not supported');
      }
    } catch (e) {
      return defaultValue;
    }
  }

}