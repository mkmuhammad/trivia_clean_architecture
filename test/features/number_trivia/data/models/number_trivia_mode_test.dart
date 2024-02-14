import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test');

  test('should be s subclass NumberTriviaEntity', () async {
    //assert
    expect(tNumberTriviaModel, isA<NumberTriviaEntity>());
  });

  group('from json', () {
    test('should return valid model when the json is an integer', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));

      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert

      expect(result, isA<NumberTriviaEntity>());
    });

    test('should return valid model when the json is regarded as a double',
        () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));

      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert

      expect(result, isA<NumberTriviaEntity>());
    });
  });

  group('toJson', () {
    test('should return a Json containing the proper data', () {
      //arrange

      //act
      final result = tNumberTriviaModel.toJson();
      //assert

      const expectedMap = {
        "text": "1e+40 is the Eddington-Dirac number",
        "number": 100,
      };

      expect(result, isA<Map<String, dynamic>>());
    });
  });
}
