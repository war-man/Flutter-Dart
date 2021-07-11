import 'package:flutter_clean_architecture_number_trivia_app/core/presentation/util/input_converter.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:dartz/dartz.dart';

void main() {
  InputConverter inputConverter;
  setUp(() {
    inputConverter = InputConverter();
  });

  group("String to UnsignedInt", () {
    test(
      'should return an integer when the string represent an unsigned int (non negative number)',
      () async {
        // arrange
        final inputStr = '123';

        // act
        final result = inputConverter.stringToUnsignedInteger(inputStr);

        // assert
        expect(result, equals(Right(123)));
      },
    );

    test(
      'should return a failure when the string is not integer',
      () async {
        // arrange
        final inputStr = '1.5';

        // act
        final result = inputConverter.stringToUnsignedInteger(inputStr);

        // assert
        expect(result, equals(Left(InvalidInputFailure())));
      },
    );

    test(
      'should return a failure when the string is an negative number',
      () async {
        // arrange
        final inputStr = '-123';

        // act
        final result = inputConverter.stringToUnsignedInteger(inputStr);

        // assert
        expect(result, equals(Left(InvalidInputFailure())));
      },
    );
  });
}
