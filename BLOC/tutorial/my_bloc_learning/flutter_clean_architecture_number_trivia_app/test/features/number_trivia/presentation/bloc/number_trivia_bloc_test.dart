import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_clean_architecture_number_trivia_app/core/presentation/util/input_converter.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  blocTest(
    ("initialState should be NumberTriviaInitial"),
    build: () {
      return NumberTriviaBloc(
          getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
          getRandomNumberTrivia: mockGetRandomNumberTrivia,
          inputConverter: mockInputConverter);
    },
    expect: [],
  );

  // !NOTE : OLD WAYS
  // test(
  //   'initialState should be NumberTriviaInitial ',
  //   () {
  //     // assert
  //     expect(bloc, NumberTriviaInitial());
  //   },
  // );

  group("GetTriviaForConcreteNumber", () {
    final testNumberString = "1";
    final testNumberParsed = 1;
    final testNumberTrivia = NumberTrivia(text: "test trivia", number: 1);

    // ! NOTE: OLD WAYS
    // test(
    //   'should call the InputConverter to validate and convert the string to an unsigned integer',
    //   () async {
    //     // arrange
    //     when(mockInputConverter.stringToUnsignedInteger(any))
    //         .thenReturn(Right(testNumberParsed));

    //     // act
    //     bloc.add(GetTriviaFromConcreteNumber(testNumberString));
    //     await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

    //     // assert
    //     verify(mockInputConverter.stringToUnsignedInteger(testNumberString));
    //   },
    // );

    blocTest(
      ("should call the InputConverter to validate and convert the string to an unsigned integer"),
      build: () {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(testNumberParsed));
        return NumberTriviaBloc(
            getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
            getRandomNumberTrivia: mockGetRandomNumberTrivia,
            inputConverter: mockInputConverter);
      },
      act: (bloc) => bloc.add(GetTriviaFromConcreteNumber(testNumberString)),
      verify: (_) =>
          mockInputConverter.stringToUnsignedInteger(testNumberString),
    );

    // ! NOTE: Old ways
    // test(
    //   'should emit [Error] when the input is invalid',
    //   () async {
    //     // arrange
    //     when(mockInputConverter.stringToUnsignedInteger(any))
    //         .thenReturn(Left(InvalidInputFailure()));
    //     // assert later
    //     final expected = [
    //       NumberTriviaInitial(),
    //       NumberTriviaErrorState(errorMessage: INVALID_INPUT_FAILURE_MESSAGE),
    //     ];
    //     expectLater(bloc, emitsInOrder(expected));
    //     // act
    //     bloc.add(GetTriviaFromConcreteNumber(testNumberString));
    //   },
    // );

    blocTest('should emit NumberTriviaErrorState when the input is invalid',
        build: () {
          when(mockInputConverter.stringToUnsignedInteger(any))
              .thenReturn(Left(InvalidInputFailure()));
          return NumberTriviaBloc(
              getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
              getRandomNumberTrivia: mockGetRandomNumberTrivia,
              inputConverter: mockInputConverter);
        },
        act: (bloc) => bloc.add(GetTriviaFromConcreteNumber(testNumberString)),
        expect: [
          NumberTriviaErrorState(errorMessage: INVALID_INPUT_FAILURE_MESSAGE)
        ]);
  });
}
