import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_number_trivia_app/core/error/failure.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String input) {
    try {
      final parseInteger = int.parse(input);
      if (parseInteger < 0) {
        throw FormatException();
      } else {
        return Right(parseInteger);
      }
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
