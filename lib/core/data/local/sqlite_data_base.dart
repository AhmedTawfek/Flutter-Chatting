// lib/data/datasources/local/database/database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:path/path.dart';

class SqliteDatabase {
  static const _databaseName = 'app_database.db';
  static const _databaseVersion = 1;

  static const chatTable = 'chat';
  static const messagesTable = 'messages';
  static const filesTable = 'files';
  static const imagesTable = 'images';

  SqliteDatabase._privateConstructor();

  static final SqliteDatabase instance = SqliteDatabase._privateConstructor();

  BriteDatabase? _briteDb;

  Future<BriteDatabase> get database async {
    if (_briteDb != null) return _briteDb!;
    _briteDb = await _initDatabase();
    return _briteDb!;
  }

  Future<BriteDatabase> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    final db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );

    return BriteDatabase(db);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $chatTable (
        id INTEGER NOT NULL,
        chat_id TEXT UNIQUE,
        title TEXT,
        created_at TEXT,
        last_modified TEXT,
        image_url TEXT,
        PRIMARY KEY(id AUTOINCREMENT)
      )
    ''');

    await db.execute('''
  CREATE TABLE $messagesTable (
    id INTEGER NOT NULL,
    message_id TEXT UNIQUE,
    message TEXT,
    chat_id TEXT,
    message_type INTEGER,
    sent_at TEXT,
    last_modified TEXT,
    sender_id TEXT,
    edited INTEGER,
    deleted INTEGER,
    reply_message_id TEXT,
    uploaded INTEGER,
    PRIMARY KEY(id AUTOINCREMENT)
  )
''');

    await db.execute('''
  CREATE TABLE $filesTable (
    id INTEGER NOT NULL,
    message_id TEXT UNIQUE,
    file_url TEXT,
    file_name TEXT,
    file_size TEXT,
    file_type TEXT,
    PRIMARY KEY(id AUTOINCREMENT)
  )
''');

    await db.execute('''
      CREATE TABLE $imagesTable (
	id	INTEGER NOT NULL,
	message_id TEXT NOT NULL UNIQUE,
	server_url	TEXT,
	local_url	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
    )
    ''');
  }

  Future<void> close() async {
    await _briteDb?.close();
    _briteDb = null;
  }
}
