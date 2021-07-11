import 'dart:convert';

import 'package:flutter_clean_architecture_number_trivia_app/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/data/datasources/number_trivia_local_datasources.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/data/datasources/number_trivia_remote_datasources.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock with http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl remoteDataSource;

  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setupMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture("trivia.json"), 200));
  }

  void setupMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response("something wrong", 404));
  }

  group("getConcreteNumberTrivia", () {
    final testNumber = 1;
    final testNumberTrivia =
        NumberTriviaModel.fromJson(jsonDecode(fixture("trivia.json")));
    test(
      'should perform a GET request on a URL with number being the endpoint and with application/json header',
      () async {
        // arrange
        setupMockHttpClientSuccess200();

        // act
        remoteDataSource.getConcreteNumberTrivia(testNumber);

        // assert
        verify(mockHttpClient.get("http://numbersapi.com/$testNumber",
            headers: {"Content-Type": "application/json"}));
      },
    );

    test(
      'should return NumberTriviaModel when the response code is 200 (success)',
      () async {
        // arrange
        setupMockHttpClientSuccess200();

        // act
        final result =
            await remoteDataSource.getConcreteNumberTrivia(testNumber);

        // assert
        verify(mockHttpClient.get("http://numbersapi.com/$testNumber",
            headers: {"Content-Type": "application/json"}));
        expect(result, equals(testNumberTrivia));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setupMockHttpClientFailure404();
        // act
        final result = remoteDataSource.getConcreteNumberTrivia(testNumber);

        // assert
        verify(mockHttpClient.get("http://numbersapi.com/$testNumber",
            headers: {"Content-Type": "application/json"}));
        expect(result, throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group("getRandomNumberTrivia", () {
    final testNumberTrivia =
        NumberTriviaModel.fromJson(jsonDecode(fixture("trivia.json")));
    test(
      'should perform a GET request on a URL with number being the endpoint and with application/json header',
      () async {
        // arrange
        setupMockHttpClientSuccess200();

        // act
        remoteDataSource.getRandomNumberTrivia();

        // assert
        verify(mockHttpClient.get("http://numbersapi.com/random",
            headers: {"Content-Type": "application/json"}));
      },
    );

    test(
      'should return NumberTriviaModel when the response code is 200 (success)',
      () async {
        // arrange
        setupMockHttpClientSuccess200();

        // act
        final result = await remoteDataSource.getRandomNumberTrivia();

        // assert
        verify(mockHttpClient.get("http://numbersapi.com/random",
            headers: {"Content-Type": "application/json"}));
        expect(result, equals(testNumberTrivia));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setupMockHttpClientFailure404();
        // act
        final result = remoteDataSource.getRandomNumberTrivia();

        // assert
        verify(mockHttpClient.get("http://numbersapi.com/random",
            headers: {"Content-Type": "application/json"}));
        expect(result, throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
