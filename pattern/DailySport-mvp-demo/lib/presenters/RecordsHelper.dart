
import 'package:daily_sport_mvp_flutter/utils/DBmanager.dart';
import 'package:daily_sport_mvp_flutter/model/Record.dart';
import 'package:daily_sport_mvp_flutter/utils/DateTimeUtils.dart';


/// This class is the presenter for home class.

class RecordsHelper{

  static Future<bool> saveRecord(int minutes) async {

    //use current time stamp as record id
    int id = DateTimeUtils.getTimestampNow();

    //get date of today
    String date = DateTimeUtils.getDateToday();

    //form record entity
    Record record = new Record.create(id, date, minutes);

    //save to DB
    await DBmanager.instance.insertNewRecord(record);

    return Future.value(true);
  }

  static Future<int> getTodayRecords() async {

    //get date of today
    String datetoday = DateTimeUtils.getDateToday();

    //return total minutes of today
    return await DBmanager.instance.getOneDayMinutes(datetoday);
  }

  static getAllRecords(){
    DBmanager.instance.getAllRecords().then((list){

    });
  }
}