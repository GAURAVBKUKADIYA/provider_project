import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Database db;


  Future<Database> create_db() async
  {
    if (db == null) {
      Directory dir = await getApplicationDocumentsDirectory();
      String path = join(dir.path, "shop_db");
      var db = await openDatabase(path, version: 1, onCreate: create_table);
      return db;
    }
    else {
      return db;
    }
  }

  create_table(Database db, int verssion) async
  {
    db.execute(
        "create table  expense (eid integer primary key autoincrement,expense_head text ,descp text, typ text,amount double,dat text)");
    print("data has loded");
  }
}