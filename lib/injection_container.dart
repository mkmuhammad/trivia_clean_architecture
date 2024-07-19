import 'package:connecteo/connecteo.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_clean_architecture/core/utils/input_converter.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia_usecase.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia_usecase.dart';
import 'package:trivia_clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import 'core/network/network_info.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

void init() {
  //! Features - Number Trivia
  //BLoC
  sl.registerFactory<NumberTriviaBloc>(
    () => NumberTriviaBloc(
      getConcreteNumberTriviaUsecase: sl<GetConcreteNumberTriviaUsecase>(),
      getRandomNumberTriviaUsecase: sl<GetRandomNumberTriviaUsecase>(),
      inputConverter: sl<InputConverter>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton<GetConcreteNumberTriviaUsecase>(
    () => GetConcreteNumberTriviaUsecase(sl<NumberTriviaRepository>()),
  );

  sl.registerLazySingleton<GetRandomNumberTriviaUsecase>(
    () => GetRandomNumberTriviaUsecase(sl<NumberTriviaRepository>()),
  );

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl<NumberTriviaRemoteDataSource>(),
      localDataSource: sl<NumberTriviaLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(
      client: sl<http.Client>(),
    ),
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
        sharedPreferences: sl<SharedPreferences>()),
  );

  //! Core
  sl.registerLazySingleton<InputConverter>(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<ConnectionChecker>()));

  //! External
  // final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());

  sl.registerLazySingleton<http.Client>(() => http.Client());

  sl.registerLazySingleton<ConnectionChecker>(() => ConnectionChecker());
}
