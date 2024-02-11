import 'package:dartz/dartz.dart';
import 'package:trivia_clean_architecture/core/error/failures.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia_usecase.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late GetConcreteNumberTriviaUsecase usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTriviaUsecase(mockNumberTriviaRepository);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTriviaEntity(text: 'test', number: 1);

  test(
    'should get trivia for the number from the repository',
    () async {
      // arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      // act
      final result = await usecase(const Params(number: tNumber));

      //assert
      expect(result, const Right<Failure, NumberTriviaEntity>(tNumberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
