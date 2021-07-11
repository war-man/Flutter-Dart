import 'package:tinder_flutter_app/data/model/user_data.dart';
import 'package:tinder_flutter_app/network/api_client.dart';
import 'package:tinder_flutter_app/network/api_endpoints.dart';

class UserRemoteDataSource {
  ApiClient _client;

  UserRemoteDataSource() {
    _client = ApiClient();
  }

  Future<UserData> getUserData({int count = 5}) async {
    Map<String, dynamic> jsonData =
        await _client.get('${ApiEndpoints.randomUserList}$count');
    return UserData.fromJson(jsonData);
  }
}
