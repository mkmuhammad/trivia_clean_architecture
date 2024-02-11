import 'package:dartz/dartz.dart';
import 'package:trivia_clean_architecture/core/error/failures.dart';
import 'package:trivia_clean_architecture/core/usecases/usecase.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia_usecase.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late GetRandomNumberTriviaUsecase usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTriviaUsecase(mockNumberTriviaRepository);
  });

  const tNumberTrivia = NumberTriviaEntity(text: 'test', number: 1);

  test(
    'should get trivia from the repository',
    () async {
      // arrange
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => const Right(tNumberTrivia));

      // act
      final result = await usecase(NoParams());

      //assert
      expect(result, const Right<Failure, NumberTriviaEntity>(tNumberTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
