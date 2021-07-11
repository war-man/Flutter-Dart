import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{

  // setting this to avoid users inputting wrong characters
  static const NUMBER = 'number';
  static const ID = 'id';

  String? _number;
  String? _id;

  // setting getters

  String? get number =>_number;
  String? get id =>_id;

  UserModel.fromSnapshot(DocumentSnapshot snapshot){
    _number = snapshot.get(NUMBER);
    _id = snapshot.get(ID);
  }


}