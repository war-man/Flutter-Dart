import 'dart:convert';

import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final testNumberTriviaModel = NumberTriviaModel(number: 1, text: "Test text");
  final testNumberTriviaModelNull =
      NumberTriviaModel(number: null, text: "Test text");

  test(
    'should be a subclass of NumberTrivia entity',
    () async {
      // assert
      print("result -> $testNumberTriviaModel");
      expect(testNumberTriviaModel, isA<NumberTrivia>());
    },
  );

  group("fromJson", () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = jsonDecode(fixture("trivia.json"));

        // act
        final result = NumberTriviaModel.fromJson(jsonMap);
        print("result -> $result");

        // assert
        expect(result, testNumberTriviaModel);
      },
    );

    test(
      'should return a valid model when the JSON number is regaded as a double',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            jsonDecode(fixture("trivia_double.json"));

        // act
        final result = NumberTriviaModel.fromJson(jsonMap);
        print("result -> $result");

        // assert
        expect(result, testNumberTriviaModel);
      },
    );
  });

  test(
    'should return a valid model when the JSON number is regarded as a null',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture("trivia_null.json"));

      // act
      final result = NumberTriviaModel.fromJson(jsonMap);
      print("result -> $result");

      // assert
      expect(result, testNumberTriviaModelNull);
    },
  );

  group("toJson", () {
    test(
      'should return a JSON Map containing proper data',
      () async {
        // act
        final result = testNumberTriviaModel.toJson();

        print("result -> $result");

        final expectedJsonMap = {
          "text": "Test text",
          "number": 1,
        };

        // assert
        expect(result, expectedJsonMap);
      },
    );
  });
}
