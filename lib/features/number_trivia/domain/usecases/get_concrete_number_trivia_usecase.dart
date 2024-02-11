import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:trivia_clean_architecture/core/usecases/usecase.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

import '../../../../core/error/failures.dart';

class GetConcreteNumberTriviaUsecase
    implements Usecase<NumberTriviaEntity, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTriviaUsecase(this.repository);

  @override
  Future<Either<Failure, NumberTriviaEntity>?> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object?> get props => [number];
}
