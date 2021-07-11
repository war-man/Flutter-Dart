import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:tinder_flutter_app/data/model/user_data.dart';
import 'package:tinder_flutter_app/domain/usecases/user_user_case.dart';
import 'package:tinder_flutter_app/presentation/journey/home/bloc/home_event.dart';
import 'package:tinder_flutter_app/presentation/journey/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  UserUseCase userCase;

  HomeBloc() : super(InitialHomeState()) {
    this.userCase = UserUseCase();
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event.runtimeType) {
      case LoadUserDataEvent:
        {
          yield* _mapLoadUserDataEventToState(event);
        }
    }
  }

  Stream<HomeState> _mapLoadUserDataEventToState(LoadUserDataEvent event) async* {
    yield LoadingState();
    final UserData userData = await userCase.getUserData();
    yield LoadedState(userData);
  }
}
