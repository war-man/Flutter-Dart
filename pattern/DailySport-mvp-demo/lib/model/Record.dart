

class Record {

  int id;
  String date;
  int minutes;

  Record();

  Record.create(id, date, minutes)
      : id = id,
        date = date,
        minutes = minutes;

  Record.parse(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        minutes = json['minutes'];
}