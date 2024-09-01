abstract interface class LocalStorage {
  Future<V?> read<V>(String key);
  Future<void> write<V>(String key, V valor);
  Future<bool> contains(String key);
  Future<void> clear();
  Future<void> remove(String key);
}


abstract interface class LocalSecureStorage {
  Future<String?> read(String key);
  Future<void> write(String key, String valor);
  Future<bool> contains(String key);
  Future<void> clear();
  Future<void> remove(String key);
}