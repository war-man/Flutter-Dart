import 'package:flutter_clean_architecture_number_trivia_app/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group("isConnected", () {
    test(
      'should forward the call to the DataConnectionChecker.hasConnection',
      () async {
        // arrange
        final testHasConnectionFuture = Future.value(true);
        when(mockDataConnectionChecker.hasConnection)
            .thenAnswer((_) => testHasConnectionFuture);

        // act
        final result = networkInfo.isConnected;

        // assert
        verify(mockDataConnectionChecker.hasConnection);
        expect(result, testHasConnectionFuture);
      },
    );
  });
}
