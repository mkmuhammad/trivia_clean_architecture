import 'package:dartz/dartz.dart';
import 'package:trivia_clean_architecture/core/error/failures.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia_entity.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTriviaEntity>>? getConcreteNumberTrivia(
      int? number);

  Future<Either<Failure, NumberTriviaEntity>>? getRandomNumberTrivia();
}
