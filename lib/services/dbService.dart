
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:todo_app/model/task.dart';

class DbService{

  static const _databaseName = 'TaskData.db';
  static const _databaseVersion = 1;


  //Singleton class
  DbService._();
  static final DbService instance = DbService._();

  Database _database;
  Future<Database> get database async{
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  //initialize database
  _initDatabase() async{
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = await join(dataDirectory.path, _databaseName);
    
    return await openDatabase(dbPath,version: _databaseVersion,onCreate: _onCreateDb);
  }


  //create task table
  _onCreateDb(Database db,int version)async{

    await db.execute('''
      CREATE TABLE ${Task.tblTask}(
        ${Task.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Task.colTask} TEXT NOT NULL,
        ${Task.colAddBy} TEXT NOT NULL
      )
    ''');
  }

  //insert tasks into a task table
  Future<int> insertTask(Task task) async{
    Database db = await database;
    return await db.insert(Task.tblTask, task.toMap());
  }


  //fetch tasks list from database
  Future<List<Task>> fetchTasks() async{
    Database db = await database;
    List<Map> tasks = await db.query(Task.tblTask);
    return tasks.length == 0 ? [] : tasks.map((e) => Task.fromMap(e)).toList();
  }

}