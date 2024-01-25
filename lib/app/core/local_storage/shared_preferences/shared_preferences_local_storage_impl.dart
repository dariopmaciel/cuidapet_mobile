import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocalStorageImpl implements LocalStorage {
  Future<SharedPreferences> get _instace => SharedPreferences.getInstance();

  @override
  Future<void> clear() async {
    final sharedPreferences = await _instace;
    sharedPreferences.clear();
  }

  @override
  Future<bool> contains(String key) async {
    final sharedPreferences = await _instace;
    return sharedPreferences.containsKey(key);
  }

  @override
  Future<V?> read<V>(String key) async {
    final sharedPreferences = await _instace;
    return sharedPreferences.get(key) as V?;
  }

  @override
  Future<void> remove(String key) async {
    final sharedPreferences = await _instace;
    sharedPreferences.remove(key);
  }

  @override
  Future<void> write<V>(String key, V value) async {
    final sharedPreferences = await _instace;

    // if (V == String) {
    //   await sharedPreferences.setString(key, value as String);
    // }
    switch (V) {
      // case String:
        case const (String):
        await sharedPreferences.setString(key, value as String);
        break;
      // case int:
        case const (int):
        await sharedPreferences.setInt(key, value as int);
        break;
      // case bool:
        case const (bool):
        await sharedPreferences.setBool(key, value as bool);
        break;
      // case double:
        case const (double):
        await sharedPreferences.setDouble(key, value as double);
        break;
      // case List<String>:
      case const (List<String>):
        await sharedPreferences.setStringList(key, value as List<String>);
        break;
      default:
        throw Exception('Type not suported');
    }
  }
}
