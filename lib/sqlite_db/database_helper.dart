import 'dart:io';
import 'package:health_test/sqlite_db/exercise_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class ExerciseDatabaseHelper {
  static Database? _productDb;
  static ExerciseDatabaseHelper? _exerciseDatabaseHelper;

  String table = 'exerciseTable';
  String colId = 'id';
  String colName = 'name';
  String colDescription = "description";

  ExerciseDatabaseHelper._createInstance();

  static final ExerciseDatabaseHelper db = ExerciseDatabaseHelper._createInstance();

  factory ExerciseDatabaseHelper() {
    if (_exerciseDatabaseHelper == null) {
      _exerciseDatabaseHelper = ExerciseDatabaseHelper._createInstance();
    }
    return _exerciseDatabaseHelper!;
  }

  Future<Database> get database async {
    if (_productDb == null) {
      _productDb = await initializeDatabase();
    }
    return _productDb!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'exercises.db';
    var myDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return myDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $table"
        "($colId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$colName TEXT, $colDescription TEXT)");
  }

  Future<List<Map<String, dynamic>>> getExerciseMapList() async {
    Database db = await this.database;
    var result = await db.query(table, orderBy: "$colId ASC");
    return result;
  }

  Future<int> insertExercise(Exercise exerciseInstance) async {
    Database db = await this.database;
    var result = await db.insert(table, exerciseInstance.toMap());
    print(result);
    return result;
  }

  Future<int> updateExercise(Exercise exerciseInstance) async {
    var db = await this.database;
    var result = await db.update(table, exerciseInstance.toMap(),
        where: '$colId = ?', whereArgs: [exerciseInstance.id]);
    return result;
  }

  Future<int> deleteExercise(int id) async {
    var db = await this.database;
    int result = await db
        .delete(table, where: '$colId = ?', whereArgs: [id]);
    return result;
  }

  Future<int?> getCount(tableName) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $tableName');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Exercise>> getExerciseList() async {
    var productMapList = await getExerciseMapList();
    int? count = await getCount(table);

    List<Exercise> productList = <Exercise>[];
    for (int i = 0; i < count!; i++) {
      productList.add(Exercise.fromMap(productMapList[i]));
    }
    return productList;
  }

  close() async {
    var db = await database;
    var result = db.close();
    return result;
  }
}