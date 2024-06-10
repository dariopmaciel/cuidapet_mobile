abstract interface class LocalStorage {
  Future<V?> read<V>(String key);
  Future<void> write<V>(String key, V valor);
  Future<bool> contains(String key);
  Future<void> clear();
  Future<void> remove(String key);
}

abstract interface class LocalSecureStorage {}
