import 'package:connecteo/connecteo.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_clean_architecture/core/network/network_info.dart';

class MockConnectionChecker extends Mock implements ConnectionChecker {
  @override
  Future<bool> get isConnected => super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: Future.value(true),
        returnValueForMissingStub: Future.value(true),
      );
}

void main() {
  late MockConnectionChecker mockConnectionChecker;
  late NetworkInfoImpl networkInfoImpl;

  setUp(() {
    mockConnectionChecker = MockConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockConnectionChecker);
  });

  group('isConnected', () {
    test('should forward the call to ConnectionChecker.isConnected', () async {
      // arrange
      final tHasConnectionFuture = Future.value(true);

      when(mockConnectionChecker.isConnected)
          .thenAnswer((_) => tHasConnectionFuture);
      // act
      final result = networkInfoImpl.isConnected;
      // assert
      verify(mockConnectionChecker.isConnected);
      expect(result, tHasConnectionFuture);
    });
  });
}
