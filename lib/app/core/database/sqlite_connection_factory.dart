import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class SqliteConnectionFactory {
  static const _version = 1;
  static const _databaseName = "CUIDAPET_LOCAL_DB";
  static SqliteConnectionFactory? _instace;

  Database? _db;
  final _lock = Lock();

  SqliteConnectionFactory._();

  factory SqliteConnectionFactory() {
    _instace ??= SqliteConnectionFactory._();
    return _instace!;
  }

  Future<Database> openConnection() async {
    if (_db == null) {
      await _lock.synchronized(() async {
        if (_db == null) {
          final databasePath = await getDatabasesPath();
          final pathDatabase = join(databasePath, _databaseName);
          _db = await openDatabase(
            pathDatabase,
            version: _version,
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
          );
        }
      });
    }
    return _db!;
  }

  FutureOr<void> _onConfigure(Database db) {
    //
  }

  FutureOr<void> _onCreate(Database db, int version) {
    //
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
    //
  }
}
