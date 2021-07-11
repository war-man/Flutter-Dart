import 'dart:convert';

import 'package:flutter_clean_architecture_number_trivia_app/core/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

const GET_NUMBER_TRIVIA_URL = "http://numbersapi.com/";
const GET_RANDOM_NUMBER_TRIVIA_URL = "http://numbersapi.com/random";

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({@required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getNumberTriviaFromURL("$GET_NUMBER_TRIVIA_URL$number");

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getNumberTriviaFromURL(GET_RANDOM_NUMBER_TRIVIA_URL);

  Future<NumberTriviaModel> _getNumberTriviaFromURL(String url) async {
    final response =
        await client.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final result = NumberTriviaModel.fromJson(jsonDecode(response.body));
      return result;
    } else {
      throw ServerException();
    }
  }
}
