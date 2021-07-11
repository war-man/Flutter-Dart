import 'package:tinder_flutter_app/data/model/user_data.dart';

abstract class UserRepository {
  Future<UserData> getUserData();
}
