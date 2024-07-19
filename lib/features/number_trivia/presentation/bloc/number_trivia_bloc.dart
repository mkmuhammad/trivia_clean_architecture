import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:trivia_clean_architecture/core/error/failures.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia_entity.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/input_converter.dart';
import '../../domain/usecases/get_concrete_number_trivia_usecase.dart';
import '../../domain/usecases/get_random_number_trivia_usecase.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTriviaUsecase getConcreteNumberTriviaUsecase;
  final GetRandomNumberTriviaUsecase getRandomNumberTriviaUsecase;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTriviaUsecase,
    required this.getRandomNumberTriviaUsecase,
    required this.inputConverter,
  }) : super(EmptyState()) {
    on<GetTriviaForConcreteNumberEvent>(_onGetConcreteNumberTriviaEvent);
    on<GetTriviaForRandomNumberEvent>(_onGetRandomNumberTriviaEvent);
  }

  void _onGetConcreteNumberTriviaEvent(GetTriviaForConcreteNumberEvent event,
      Emitter<NumberTriviaState> emit) async {
    final inputEither =
        inputConverter.stringToUnsignedInteger(event.numberString);
    await inputEither.fold(
      (failure) async =>
          emit(const ErrorState(message: INVALID_INPUT_FAILURE_MESSAGE)),
      (integer) async {
        emit(LoadingState());
        final failureOrTrivia =
            await getConcreteNumberTriviaUsecase(Params(number: integer));
        _emitEitherLoadedOrErrorState(failureOrTrivia, emit);
      },
    );
  }

  Future<void> _onGetRandomNumberTriviaEvent(
      GetTriviaForRandomNumberEvent event,
      Emitter<NumberTriviaState> emit) async {
    emit(LoadingState());
    final failureOrTrivia = await getRandomNumberTriviaUsecase(NoParams());
    _emitEitherLoadedOrErrorState(failureOrTrivia, emit);
  }

  void _emitEitherLoadedOrErrorState(
      Either<Failure, NumberTriviaEntity>? failureOrTrivia,
      Emitter<NumberTriviaState> emit) {
    if (failureOrTrivia == null) {
      emit(const ErrorState(message: 'Unexpected Error'));
    } else {
      failureOrTrivia.fold(
        (failure) => emit(ErrorState(message: _mapFailureToMessage(failure))),
        (trivia) => emit(LoadedState(trivia: trivia)),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
