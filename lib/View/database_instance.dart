import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'product_model.dart';

class DatabaseInstance {
  final String _databaseName = 'my_database.db';
  final int _databaseVersion = 1;

//  product Table
  final String table = 'zikir';
  final String id = 'id';
  final String email = 'email';
  final String jumlah = 'jumlah';


  Database? _database;

  Future<Database> database() async{
    if(_database != null)return _database!;
    _database = await _initDatabase();
    return _database!;

  }
  Future _initDatabase() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,_databaseName);
    return openDatabase(path,version : _databaseVersion,onCreate: _onCreate);
  }
  Future _onCreate(Database db, int version)async{
    await db.execute(
      'CREATE TABLE $table($id INTEGER PRIMARY KEY, $email Text, $jumlah Text)');
  }
  Future<List<ProductModel>> all()async{
    final data = await _database!.query(table);
    List<ProductModel> result = data.map((e)=>ProductModel.fromJson(e)).toList();
    print(result);
    return result;
  }
  Future<int> insert(Map<String, dynamic>row)async{
    final query = await _database!.insert(table, row);
    return query;
  }
}