import 'package:dartz/dartz.dart';
import 'package:trivia_clean_architecture/core/error/failures.dart';
import 'package:trivia_clean_architecture/core/platform/network_info.dart';
import 'package:trivia_clean_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:trivia_clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia_entity.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../models/number_trivia_model.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTriviaEntity>>? getConcreteNumberTrivia(
      int? number) async {
    if ((await networkInfo.isConnected) == true) {
      try {
        final remoteNumberTriviaModel =
            await remoteDataSource.getConcreteNumberTrivia(number);

        if (remoteNumberTriviaModel != null) {
          localDataSource.cacheNumberTrivia(remoteNumberTriviaModel);
          return Right(remoteNumberTriviaModel);
        } else {
          return Left(ServerFailure());
        }
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        if (localTrivia == null) {
          return Left(CacheFailure());
        } else {
          return Right(localTrivia);
        }
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, NumberTriviaEntity>>? getRandomNumberTrivia() {
    return null;
  }
}
