import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial(0));

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event is IncrementEvent) {
      yield CounterValueUpdate(value1: state.value + 1);
    } else if (event is DecrementEvent) {
      yield CounterValueUpdate(value1: state.value - 1);
    }
  }
}
