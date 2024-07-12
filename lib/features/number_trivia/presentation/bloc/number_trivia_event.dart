part of 'number_trivia_bloc.dart';

sealed class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();
}

// Event for getting trivia for a random number
class GetTriviaForConcreteNumberEvent extends NumberTriviaEvent {
  final String numberString;

  const GetTriviaForConcreteNumberEvent(this.numberString);

  @override
  List<Object> get props => [numberString];
}

// Event for getting trivia for a random number
class GetTriviaForRandomNumberEvent extends NumberTriviaEvent {
  const GetTriviaForRandomNumberEvent();

  @override
  List<Object> get props => [];
}
