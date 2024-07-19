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

final get = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  //BLoC
  get.registerFactory<NumberTriviaBloc>(
    () => NumberTriviaBloc(
      getConcreteNumberTriviaUsecase: get<GetConcreteNumberTriviaUsecase>(),
      getRandomNumberTriviaUsecase: get<GetRandomNumberTriviaUsecase>(),
      inputConverter: get<InputConverter>(),
    ),
  );

  // Use cases
  get.registerLazySingleton<GetConcreteNumberTriviaUsecase>(
    () => GetConcreteNumberTriviaUsecase(get<NumberTriviaRepository>()),
  );

  get.registerLazySingleton<GetRandomNumberTriviaUsecase>(
    () => GetRandomNumberTriviaUsecase(get<NumberTriviaRepository>()),
  );

  // Repository
  get.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: get<NumberTriviaRemoteDataSource>(),
      localDataSource: get<NumberTriviaLocalDataSource>(),
      networkInfo: get<NetworkInfo>(),
    ),
  );

  // Data Sources
  get.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(
      client: get<http.Client>(),
    ),
  );

  get.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
        sharedPreferences: get<SharedPreferences>()),
  );

  //! Core
  get.registerLazySingleton<InputConverter>(() => InputConverter());
  get.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(get<ConnectionChecker>()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  get.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  get.registerLazySingleton<http.Client>(() => http.Client());

  get.registerLazySingleton<ConnectionChecker>(() => ConnectionChecker());
}
