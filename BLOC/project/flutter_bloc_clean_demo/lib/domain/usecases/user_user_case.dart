import 'package:tinder_flutter_app/data/model/user_data.dart';
import 'package:tinder_flutter_app/data/repositories/user_repository_impl.dart';
import 'package:tinder_flutter_app/domain/repositories/user_repository.dart';

class UserUseCase {
  UserRepository _userRepository;

  UserUseCase() {
    this._userRepository = UserRepositoryImpl();
  }

  Future<UserData> getUserData() => _userRepository.getUserData();
}
