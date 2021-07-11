import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_number_trivia_app/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_number_trivia_app/core/error/failure.dart';
import 'package:flutter_clean_architecture_number_trivia_app/core/network/network_info.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/data/datasources/number_trivia_local_datasources.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/data/datasources/number_trivia_remote_datasources.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/data/repositories/number_trivia_repositories_impl.dart';
import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviLocalDataSource {}

class MockNetworkInfo extends Mock implements NetWorkInfo {}

void main() {
  NumberTriviaRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestOnline(Function body) {
    group("Device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group("Device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group("getConcreteNumberTrivia", () {
    final testNumber = 1;
    final testNumberTriviaModel =
        NumberTriviaModel(text: "Test text", number: testNumber);
    final NumberTrivia testNumberTrivia = testNumberTriviaModel;
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        // act
        repository.getConcreteNumberTrivia(testNumber);

        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is succesful',
        () async {
          // arrange
          when(mockRemoteDataSource.getConcreteNumberTrivia(any))
              .thenAnswer((_) async => testNumberTriviaModel);

          // act
          final result = await repository.getConcreteNumberTrivia(testNumber);
          print("result -> $result");

          // assert
          verify(mockRemoteDataSource.getConcreteNumberTrivia(testNumber));
          expect(result, equals(Right(testNumberTrivia)));
        },
      );

      test(
        'should cached the data locally when the call to remote data source is succesful',
        () async {
          // arrange
          when(mockRemoteDataSource.getConcreteNumberTrivia(any))
              .thenAnswer((_) async => testNumberTriviaModel);

          // act
          await repository.getConcreteNumberTrivia(testNumber);

          // assert
          verify(mockRemoteDataSource.getConcreteNumberTrivia(testNumber));
          verify(mockLocalDataSource.cacheNumberTrivia(testNumberTriviaModel));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccesful',
        () async {
          // arrange
          when(mockRemoteDataSource.getConcreteNumberTrivia(any))
              .thenThrow(ServerException());

          // act
          final result = await repository.getConcreteNumberTrivia(testNumber);
          print("result -> $result");

          // assert
          verify(mockRemoteDataSource.getConcreteNumberTrivia(testNumber));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestOffline(() {
      test(
        'should return last local cache data when the cache data is present ',
        () async {
          // arrange
          when(mockLocalDataSource.getLastNumberTrivia())
              .thenThrow(CacheException());

          // act
          final result = await repository.getConcreteNumberTrivia(testNumber);

          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, equals(Left(CacheFailure())));
        },
      );

      test(
        'should return CacheFailure when there is no cache data present ',
        () async {
          // arrange
          when(mockLocalDataSource.getLastNumberTrivia())
              .thenAnswer((_) async => testNumberTriviaModel);

          // act
          final result = await repository.getConcreteNumberTrivia(testNumber);

          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, equals(Right(testNumberTrivia)));
        },
      );
    });
  });

  group("getRandomNumberTrivia", () {
    final testNumberTriviaModel =
        NumberTriviaModel(text: "Test text", number: 123);
    final NumberTrivia testNumberTrivia = testNumberTriviaModel;
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        // act
        repository.getRandomNumberTrivia();

        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is succesful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRandomNumberTrivia())
              .thenAnswer((_) async => testNumberTriviaModel);

          // act
          final result = await repository.getRandomNumberTrivia();
          print("result -> $result");

          // assert
          verify(mockRemoteDataSource.getRandomNumberTrivia());
          expect(result, equals(Right(testNumberTrivia)));
        },
      );

      test(
        'should cached the data locally when the call to remote data source is succesful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRandomNumberTrivia())
              .thenAnswer((_) async => testNumberTriviaModel);

          // act
          await repository.getRandomNumberTrivia();

          // assert
          verify(mockRemoteDataSource.getRandomNumberTrivia());
          verify(mockLocalDataSource.cacheNumberTrivia(testNumberTriviaModel));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccesful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRandomNumberTrivia())
              .thenThrow(ServerException());

          // act
          final result = await repository.getRandomNumberTrivia();
          print("result -> $result");

          // assert
          verify(mockRemoteDataSource.getRandomNumberTrivia());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestOffline(() {
      test(
        'should return last local cache data when the cache data is present ',
        () async {
          // arrange
          when(mockLocalDataSource.getLastNumberTrivia())
              .thenThrow(CacheException());

          // act
          final result = await repository.getRandomNumberTrivia();

          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, equals(Left(CacheFailure())));
        },
      );

      test(
        'should return CacheFailure when there is no cache data present ',
        () async {
          // arrange
          when(mockLocalDataSource.getLastNumberTrivia())
              .thenAnswer((_) async => testNumberTriviaModel);

          // act
          final result = await repository.getRandomNumberTrivia();

          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, equals(Right(testNumberTrivia)));
        },
      );
    });
  });
}
