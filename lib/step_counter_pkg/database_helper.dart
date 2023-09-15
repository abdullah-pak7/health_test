import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:health_test/step_counter_pkg/steps_model.dart';

class StepsDatabaseHelper {
  static Database? _productDb;
  static StepsDatabaseHelper? _stepsDatabaseHelper;

  String table = 'stepsTable';
  String colId = 'id';
  String colName = 'steps';

  StepsDatabaseHelper._createInstance();

  static final StepsDatabaseHelper db = StepsDatabaseHelper._createInstance();

  factory StepsDatabaseHelper() {
    if (_stepsDatabaseHelper == null) {
      _stepsDatabaseHelper = StepsDatabaseHelper._createInstance();
    }
    return _stepsDatabaseHelper!;
  }

  Future<Database> get database async {
    if (_productDb == null) {
      _productDb = await initializeDatabase();
    }
    return _productDb!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'steps.db';
    var myDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return myDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $table"
        "($colId INTEGER PRIMARY KEY AUTOINCREMENT,""$colName TEXT)");
  }

  Future<List<Map<String, dynamic>>> getExerciseMapList() async {
    Database db = await this.database;
    var result = await db.query(table, orderBy: "$colId ASC");
    return result;
  }

  Future<int> insertSteps(Steps exerciseInstance) async {
    Database db = await this.database;
    var result = await db.insert(table, exerciseInstance.toMap());
    return result;
  }

  Future<int> updateSteps(Steps exerciseInstance) async {
    var db = await this.database;
    var result = await db.update(table, exerciseInstance.toMap(),
        where: '$colId = ?', whereArgs: [exerciseInstance.id]);
    return result;
  }

  Future<int> deleteSteps(int id) async {
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

  Future<List<Steps>> getExerciseList() async {
    var productMapList = await getExerciseMapList();
    int? count = await getCount(table);

    List<Steps> productList = <Steps>[];
    for (int i = 0; i < count!; i++) {
      productList.add(Steps.fromMap(productMapList[i]));
    }
    return productList;
  }

  close() async {
    var db = await database;
    var result = db.close();
    return result;
  }
}