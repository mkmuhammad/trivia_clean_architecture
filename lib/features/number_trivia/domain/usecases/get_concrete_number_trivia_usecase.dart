import 'package:dartz/dartz.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

import '../../../../core/error/failures.dart';

class GetConcreteNumberTriviaUsecase {
  final NumberTriviaRepository repository;

  GetConcreteNumberTriviaUsecase(this.repository);

  Future<Either<Failure, NumberTriviaEntity>> execute(
      {required int number}) async {
    return await repository.getConcreteNumberTrivia(number);
  }
}
