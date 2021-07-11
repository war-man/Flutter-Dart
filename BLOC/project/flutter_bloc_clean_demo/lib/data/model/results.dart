import 'package:tinder_flutter_app/data/model/dob.dart';
import 'package:tinder_flutter_app/data/model/id.dart';
import 'package:tinder_flutter_app/data/model/location.dart';
import 'package:tinder_flutter_app/data/model/login.dart';
import 'package:tinder_flutter_app/data/model/name.dart';
import 'package:tinder_flutter_app/data/model/picture.dart';

class Results {
  String gender;
  Name name;
  Location location;
  String email;
  Login login;
  Dob dob;
  Dob registered;
  String phone;
  String cell;
  Id id;
  Picture picture;
  String nat;

  Results(
      {this.gender,
      this.name,
      this.location,
      this.email,
      this.login,
      this.dob,
      this.registered,
      this.phone,
      this.cell,
      this.id,
      this.picture,
      this.nat});

  Results.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    email = json['email'];
    login = json['login'] != null ? new Login.fromJson(json['login']) : null;
    dob = json['dob'] != null ? new Dob.fromJson(json['dob']) : null;
    registered = json['registered'] != null
        ? new Dob.fromJson(json['registered'])
        : null;
    phone = json['phone'];
    cell = json['cell'];
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    picture =
        json['picture'] != null ? new Picture.fromJson(json['picture']) : null;
    nat = json['nat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['email'] = this.email;
    if (this.login != null) {
      data['login'] = this.login.toJson();
    }
    if (this.dob != null) {
      data['dob'] = this.dob.toJson();
    }
    if (this.registered != null) {
      data['registered'] = this.registered.toJson();
    }
    data['phone'] = this.phone;
    data['cell'] = this.cell;
    if (this.id != null) {
      data['id'] = this.id.toJson();
    }
    if (this.picture != null) {
      data['picture'] = this.picture.toJson();
    }
    data['nat'] = this.nat;
    return data;
  }
}
