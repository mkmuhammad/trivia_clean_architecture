import 'package:equatable/equatable.dart';

/// Represents a trivia entity about numbers.
///
/// This class holds the text description of the trivia and the associated number.
class NumberTriviaEntity extends Equatable {
  /// The text description of the number trivia.
  final String text;

  /// The number associated with the trivia.
  final int number;

  /// Constructs a [NumberTriviaEntity] with a [text] description and a [number].
  const NumberTriviaEntity({required this.text, required this.number});

  @override
  List<Object?> get props => [text, number];
}
