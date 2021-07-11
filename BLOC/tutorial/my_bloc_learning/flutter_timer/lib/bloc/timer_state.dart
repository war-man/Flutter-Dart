part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;
  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial(int duration) : super(duration);

  @override
  String toString() => 'Timer initial { duration: $duration}';
}

class TimerRunPause extends TimerState {
  const TimerRunPause(int duration) : super(duration);

  @override
  String toString() => 'Timer Run Pause {duration: $duration}';
}

class TimerRunInProgress extends TimerState {
  TimerRunInProgress(int duration) : super(duration);

  @override
  String toString() => 'Timer Run InProgress {duration: $duration}';
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
  @override
  String toString() => 'Timer Run Complete {duration: $duration}';
}
