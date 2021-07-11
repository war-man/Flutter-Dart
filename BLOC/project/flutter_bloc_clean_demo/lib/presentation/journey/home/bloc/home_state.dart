import 'package:tinder_flutter_app/data/model/user_data.dart';

abstract class HomeState {}

class InitialHomeState extends HomeState {}

class LoadingState extends HomeState {}

class LoadedState extends HomeState {
  final UserData userData;

  LoadedState(this.userData);
}
