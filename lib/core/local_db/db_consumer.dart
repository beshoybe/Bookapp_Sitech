import 'package:booksapp/core/errors/exceptions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class DBConsumer {
  Future get(
      {required String tableName,
      List<String>? columns,
      String? where,
      List<Object?>? whrereArgs,
      String? orderBy});
  Future<int?> insert(
      {required String tableName, required Map<String, Object?> data});
  Future<void> update({
    required String tableName,
    required Map<String, Object?> data,
    String? where,
    List<Object?>? whrereArgs,
  });
  Future<int> delete({
    required String tableName,
    String? where,
    List<Object?>? whrereArgs,
  });
}

class DBConsumerImpl implements DBConsumer {
  final Database db;
  DBConsumerImpl({required this.db});
  @override
  Future<int> delete(
      {required String tableName,
      String? where,
      List<Object?>? whrereArgs}) async {
    return await db.delete(
      tableName,
      where: where,
      whereArgs: whrereArgs,
    );
  }

  @override
  Future get(
      {required String tableName,
      List<String>? columns,
      String? where,
      List<Object?>? whrereArgs,
      String? orderBy}) async {
    try {
      return await db.query(
        tableName,
        columns: columns,
        orderBy: orderBy,
        where: where,
        whereArgs: whrereArgs,
      );
    } on DatabaseException catch (e) {
      _handleDbError(e);
    }
  }

  @override
  Future<int?> insert(
      {required String tableName, required Map<String, Object?> data}) async {
    try {
      await db.insert(tableName, data);
    } on DatabaseException catch (e) {
      _handleDbError(e);
    }
  }

  @override
  Future<void> update(
      {required String tableName,
      required Map<String, Object?> data,
      String? where,
      List<Object?>? whrereArgs}) async {
    try {
      await db.update(
        tableName,
        data,
        where: where,
        whereArgs: whrereArgs,
      );
    } on DatabaseException catch (e) {
      _handleDbError(e);
    }
  }

  dynamic _handleDbError(DatabaseException exception) {
    if (exception.isDatabaseClosedError()) {
      throw DataBaseClosedException();
    } else if (exception.isDuplicateColumnError()) {
      throw DuplicateColumnException();
    } else if (exception.isNoSuchTableError()) {
      throw TableNotFoundException();
    }
  }
}

Future<Database> databaseInit() async {
  var databasesPath = await getDatabasesPath();
  print("databse path $databasesPath");
  Database db = await openDatabase("$databasesPath/database.db", version: 1,
      onOpen: (db) async {
    await db.execute('''
        CREATE TABLE IF NOT EXISTS Books(
          id INTEGER PRIMARY KEY,
          description TEXT NOT NULL,
          author TEXT NOT NULL,
          name TEXT NOT NULL,
          cover TEXT NOT NULL,
          createdAt TEXT NOT NULL
        );
''');
    await db.execute('''
CREATE TABLE IF NOT EXISTS Bookmarks(
          id INTEGER PRIMARY KEY,
          description TEXT NOT NULL,
          author TEXT NOT NULL,
          name TEXT NOT NULL,
          cover TEXT NOT NULL,
          createdAt TEXT NOT NULL
        );''');
  });
  return db;
}
