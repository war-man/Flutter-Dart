// this is for firebase related services for users

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilesystem/models/user_model.dart';

class UserServices{

  String collection ='users';
  FirebaseFirestore _firestore =FirebaseFirestore.instance;

  // creating a new user


  Future<void>createUserData(Map<String, dynamic>values) async{
    String id = values['id'];
    await _firestore.collection(collection).doc(id).set(values);

  }

// updating user data

  Future<void>updateUserData(Map<String, dynamic>values)async{
    String id = values['id'];
    await _firestore.collection(collection).doc(id).update(values);
  }

  // getting user data by id


  Future<void>getUserById (String id)async{
    await _firestore.collection(collection).doc(id).get()
        .then((doc) {
      if(doc.data()==null){
        return null;
      }

      return UserModel.fromSnapshot(doc);
    });

  }


}