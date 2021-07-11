import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/domain/repositories/number_trivia_repositories.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final testNumber = 1;
  final testNumberTrivia = NumberTrivia(text: "testNumber", number: testNumber);

  test(
    'should get trivia for the number from repository',
    () async {
      // arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(testNumberTrivia));

      // act
      // final result = await usecase.execute(number: testNumber);
      final result = await usecase(Params(number: testNumber));
      print("result -> $result");

      // assert
      expect(result, Right(testNumberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(testNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
