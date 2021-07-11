part of 'counter_bloc.dart';

@immutable
abstract class CounterState {
  final int value;

  CounterState(this.value);
}

class CounterInitial extends CounterState {
  CounterInitial(int value) : super(value);
}

class CounterValueUpdate extends CounterState {
  final int value1;
  CounterValueUpdate({
    required this.value1,
  }) : super(0);

  List<Object> get props => [value1];
}
