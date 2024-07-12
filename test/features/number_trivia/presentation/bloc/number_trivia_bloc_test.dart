import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_clean_architecture/core/error/failures.dart';
import 'package:trivia_clean_architecture/core/usecases/usecase.dart';
import 'package:trivia_clean_architecture/core/utils/input_converter.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia_usecase.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia_usecase.dart';
import 'package:trivia_clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetConcreteNumberTriviaUsecase>(),
  MockSpec<GetRandomNumberTriviaUsecase>(),
  MockSpec<InputConverter>(),
])
class Mocks {}

void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTriviaUsecase mockGetConcreteNumberTriviaUsecase;
  late MockGetRandomNumberTriviaUsecase mockGetRandomNumberTriviaUsecase;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTriviaUsecase = MockGetConcreteNumberTriviaUsecase();
    mockGetRandomNumberTriviaUsecase = MockGetRandomNumberTriviaUsecase();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
      getConcreteNumberTriviaUsecase: mockGetConcreteNumberTriviaUsecase,
      getRandomNumberTriviaUsecase: mockGetRandomNumberTriviaUsecase,
      inputConverter: mockInputConverter,
    );
  });

  test('initial state should be EmptyState', () {
    // assert
    expect(bloc.state, equals(EmptyState()));
  });

  group('get trivia for concrete number', () {
    const tNumberString = '1';
    const tNumberParsed = 1;
    const tNumberTrivia = NumberTriviaEntity(number: 1, text: 'test');

    void setupMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(const Right(tNumberParsed));

    test(
        'should call the InputConverter to validate and convert the string to an unsigned integer',
        () async {
      // arrange
      setupMockInputConverterSuccess();

      // act
      bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));

      // assert
      await untilCalled(
          mockInputConverter.stringToUnsignedInteger(tNumberString));
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [ErrorState] when the input is invalid', () async {
      // arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      // assert later
      final expected = [
        EmptyState(),
        const ErrorState(message: INVALID_INPUT_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));
    });

    test('should get data from concrete use case', () async {
      // arrange
      setupMockInputConverterSuccess();

      when(mockGetConcreteNumberTriviaUsecase(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      // act
      bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));
      await untilCalled(mockGetConcreteNumberTriviaUsecase(any));

      // assert
      verify(mockGetConcreteNumberTriviaUsecase(
          const Params(number: tNumberParsed)));
    });

    test('should emit[Loading, Loaded] when data is gotten successfully', () {
      // arrange
      setupMockInputConverterSuccess();
      when(mockGetConcreteNumberTriviaUsecase(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      // assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        const LoadedState(trivia: tNumberTrivia),
      ];

      //act
      bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));
    });

    test('should emit[Loading, Error] when getting data fails', () {
      // arrange
      setupMockInputConverterSuccess();
      when(mockGetConcreteNumberTriviaUsecase(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      // assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        const ErrorState(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));
    });

    test('should emit[Loading, Error] when getting data fails', () {
      // arrange
      setupMockInputConverterSuccess();
      when(mockGetConcreteNumberTriviaUsecase(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      // assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        const ErrorState(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));
    });
    test(
        'should emit[Loading, Error] with a proper message for the error when getting data fails',
        () {
      // arrange
      setupMockInputConverterSuccess();
      when(mockGetConcreteNumberTriviaUsecase(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      // assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        const ErrorState(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));
    });
  });

  group('get trivia for random number', () {
    const tNumberTrivia = NumberTriviaEntity(number: 1, text: 'test');

    test('should get data from random use case', () async {
      // arrange
      when(mockGetRandomNumberTriviaUsecase(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      // act
      bloc.add(const GetTriviaForRandomNumberEvent());
      await untilCalled(mockGetRandomNumberTriviaUsecase(any));

      // assert
      verify(mockGetRandomNumberTriviaUsecase(NoParams()));
    });

    test('should emit[Loading, Loaded] when data is gotten successfully', () {
      // arrange
      when(mockGetRandomNumberTriviaUsecase(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      // assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        const LoadedState(trivia: tNumberTrivia),
      ];

      //act
      bloc.add(const GetTriviaForRandomNumberEvent());
    });

    test('should emit[Loading, Error] when getting data fails', () {
      // arrange
      when(mockGetRandomNumberTriviaUsecase(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      // assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        const ErrorState(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(const GetTriviaForRandomNumberEvent());
    });

    test('should emit[Loading, Error] when getting data fails', () {
      // arrange
      when(mockGetRandomNumberTriviaUsecase(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      // assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        const ErrorState(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(const GetTriviaForRandomNumberEvent());
    });
    test(
        'should emit[Loading, Error] with a proper message for the error when getting data fails',
        () {
      // arrange
      when(mockGetRandomNumberTriviaUsecase(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      // assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        const ErrorState(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(const GetTriviaForRandomNumberEvent());
    });
  });
}
