part of 'counter_cubit.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {
  final int value;
  CounterInitial(this.value);
  @override
  List<Object> get props => [value];
}

class CounterIncrement extends CounterState {
  final int value;

  CounterIncrement(this.value);
  @override
  List<Object> get props => [value];
}

class CounterDecrement extends CounterState {
  final int value;
  CounterDecrement(
    this.value,
  );

  @override
  List<Object> get props => [value];
}
