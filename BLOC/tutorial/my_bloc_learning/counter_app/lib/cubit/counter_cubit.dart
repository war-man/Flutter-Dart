import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  int value;
  CounterCubit(
    this.value,
  ) : super(CounterInitial(0));

  void increament() {
    value = value + 1;
    emit(CounterIncrement(value));
  }

  void decreament() {
    value = value - 1;
    emit(CounterDecrement(value));
  }
}
