import 'dart:convert';

import 'package:flutter_clean_architecture_number_trivia_app/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/data/datasources/number_trivia_local_datasources.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

const CACHED_TRIVIA_NUMBER = "CACHED_TRIVIA_NUMBER";

void main() {
  NumberTriviaLocalDataSourceImpl localDataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group("getLastNumberTrivia", () {
    final testNumberTriviaModel =
        NumberTriviaModel.fromJson(jsonDecode(fixture("trivia_cached.json")));
    test(
      'should return NumberTriviaModel from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture("trivia_cached.json"));

        // act
        final result = await localDataSource.getLastNumberTrivia();

        // assert
        verify(mockSharedPreferences.getString(CACHED_TRIVIA_NUMBER));
        expect(result, equals(testNumberTriviaModel));
      },
    );

    test(
      'should throw CacheException when there is not a cache value',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);

        // act
        final call = localDataSource.getLastNumberTrivia;

        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group("cache number trivia", () {
    final testNumberTriviaModel =
        NumberTriviaModel(text: "test Trivia", number: 1);
    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        localDataSource.cacheNumberTrivia(testNumberTriviaModel);

        // assert
        final expectedJsonString = jsonEncode(testNumberTriviaModel.toJson());
        verify(mockSharedPreferences.setString(
            CACHED_TRIVIA_NUMBER, expectedJsonString));
      },
    );
  });
}
