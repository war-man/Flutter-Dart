
import 'dart:io';

import 'package:daily_sport_mvp_flutter/model/Record.dart';
import 'package:daily_sport_mvp_flutter/utils/DateTimeUtils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DBmanager {

  static const DATABASE_NAME = "dailysport.db";
  static const DATABASE_VERSION = 1;

  /* TABLES */
  static const TABLE_RECORDS = 'table_records';

  /* RECORDS COLUMNS */
  static const String R_ID = "id";
  static const String R_DATE = "date";
  static const String R_MINUTES = "minutes";


  /* singleton class */
  DBmanager._privateConstructor();
  static final DBmanager instance = DBmanager._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DATABASE_NAME);
    return await openDatabase(path, version: DATABASE_VERSION, onCreate: _onCreate);
  }


  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $TABLE_RECORDS (
            $R_ID INTEGER PRIMARY KEY,
            $R_DATE TEXT NOT NULL,
            $R_MINUTES INTEGER DEFAULT 0
          )
          ''');
  }

  Future<int> insertNewRecord(Record record) async {
    Database db = await instance.database;
    print(record.minutes.toString());
    Map<String, dynamic> row = {
      R_ID: record.id,
      R_DATE: record.date,
      R_MINUTES: record.minutes
    };
    return await db.insert(TABLE_RECORDS, row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }


  Future<List<Record>> getAllRecords() async {
    Database db = await instance.database;

    List<Map<String, dynamic>> list = await db.query(TABLE_RECORDS, orderBy: R_ID + ' DESC');
    List<Record> records = new List<Record>();
    list.forEach((item) {
      records.add(Record.parse(item));
    });
    return records;
  }

  Future<int> getOneDayMinutes(String date) async {
    Database db = await instance.database;

    var v = await db.rawQuery('SELECT SUM($R_MINUTES) FROM $TABLE_RECORDS where $R_DATE = ?', [date]);
    int sum = v[0]['SUM($R_MINUTES)'];

    return sum;
  }
}