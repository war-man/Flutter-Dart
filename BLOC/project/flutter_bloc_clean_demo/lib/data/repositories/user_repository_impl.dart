import 'package:tinder_flutter_app/data/datasources/user_remote_data_source.dart';
import 'package:tinder_flutter_app/data/model/user_data.dart';
import 'package:tinder_flutter_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  UserRemoteDataSource userDataSource;

  UserRepositoryImpl() {
    this.userDataSource = UserRemoteDataSource();
  }

  @override
  Future<UserData> getUserData() => this.userDataSource.getUserData();
}
