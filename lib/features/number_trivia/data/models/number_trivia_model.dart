import 'package:trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia_entity.dart';

/// Represents a trivia about numbers, extending the more generic [NumberTriviaEntity].
class NumberTriviaModel extends NumberTriviaEntity {
  /// Constructs a [NumberTriviaModel] with a [text] description and a [number].
  const NumberTriviaModel({required super.text, required super.number});

  /// Creates an instance of [NumberTriviaModel] from a JSON map.
  ///
  /// Throws a [TypeError] if the JSON does not contain the expected types.
  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      text: json['text'] as String,
      number: (json['number'] as num).toInt(),
    );
  }

  /// Converts the [NumberTriviaModel] instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'number': number,
    };
  }
}
