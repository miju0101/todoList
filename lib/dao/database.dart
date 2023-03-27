import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class MyDataBase{
  static Future<void> createDB(sql.Database database) async{
    await database.execute(
      '''
      create table todos(
        id integer primary key autoincrement not null,
        title text
      )
      '''
    );
  }

  static Future<Database> db() async{
    print(await sql.getDatabasesPath());
    return sql.openDatabase(
      join(await sql.getDatabasesPath(), "myList.db"), 
      onCreate: (db, version) {
        createDB(db);
      },
      version: 1
    );
  }

  static Future<void> addTodo(String title) async{
    var db = await MyDataBase.db();

    var data = {
      'title':title,
    };

    db.insert(
      "todos", 
      data,
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<void> deleteTodo(int id) async{
    var db = await MyDataBase.db();
    try{
      db.delete(
        "todos",
        where: "id = ?",
        whereArgs: [id]
      );  
    }catch(e){
      print(e.toString());
    }
  }

  static Future<int> updateTodo(int id, String title) async{
    var db = await MyDataBase.db();

    var data = {
      "id":id,
      "title": title,
    };

    var state = await db.update(
      "todos",
      data,
      where: "id = ?",
      whereArgs: [id]
    );

    return state;
  }

  static Future<List<Map<String, dynamic>>> getTodos() async{
    var db = await MyDataBase.db();

    List<Map<String, dynamic>> datas =await db.query("todos");

    return datas;
  }

}