import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocalStorageImpl implements LocalStorage {
  Future<SharedPreferences> get _instande => SharedPreferences.getInstance();

  @override
  Future<void> clear() async {
    final sharedPreferences = await _instande;
    sharedPreferences.clear();
  }

  @override
  Future<bool> contains(String key) async {
    final sharedPreferences = await _instande;
    return sharedPreferences.containsKey(key);
  }

  @override
  Future<V?> read<V>(String key) async {
    final sharedPreferences = await _instande;
    return sharedPreferences.get(key) as V?;
  }

  @override
  Future<void> remove(String key) async {
    final sharedPreferences = await _instande;
    sharedPreferences.remove(key);
  }

  @override
  Future<void> write<V>(String key, V value) async {
    final sharedPreferences = await _instande;

    switch (V) {
      case const (String):
        await sharedPreferences.setString(key, value as String);
        break;
      case const (int):
        await sharedPreferences.setInt(key, value as int);
        break;
      case const (bool):
        await sharedPreferences.setBool(key, value as bool);
        break;
      case const (double):
        await sharedPreferences.setDouble(key, value as double);
        break;
      case const (List):
        await sharedPreferences.setStringList(key, value as List<String>);
        break;
      default:
        throw Exception("Type not suported");
    }
  }
}
