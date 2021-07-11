part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaFromConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaFromConcreteNumber(this.numberString);
  @override
  List<Object> get props => [];
}

class GetTriviaFromRandomNumber extends NumberTriviaEvent {
  @override
  List<Object> get props => [];
}
