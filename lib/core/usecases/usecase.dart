import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:trivia_clean_architecture/core/error/failures.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>?> call(Params params);
}

/// this class is defined for those usecases which does not have any parameters
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
