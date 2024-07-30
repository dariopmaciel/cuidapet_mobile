import 'dart:async';

import 'package:cuidapet_mobile/app/core/database/sqlite_migration_factory.dart';
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

  Future<FutureOr<void>> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  FutureOr<void> _onCreate(Database db, int version) {
    final batch = db.batch();
    final migrations = SqliteMigrationFactory().getCreateMigrations();
    for (var migration in migrations) {
      migration.create(batch);
    }
    batch.commit();
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
    final batch = db.batch();
    final migrations = SqliteMigrationFactory().getUpdateMigration(oldVersion);
    for (var migration in migrations) {
      migration.update(batch);
    }
    batch.commit();
  }

  void closeConnection() { //fechar conexão
    _db?.close();
    _db == null;
  }
}
