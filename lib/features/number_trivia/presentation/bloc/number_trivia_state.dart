part of 'number_trivia_bloc.dart';

sealed class NumberTriviaState extends Equatable {
  const NumberTriviaState();
}

final class EmptyState extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

final class LoadingState extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

final class LoadedState extends NumberTriviaState {
  final NumberTriviaEntity trivia;

  const LoadedState({required this.trivia});

  @override
  List<Object> get props => [trivia];
}

final class ErrorState extends NumberTriviaState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
