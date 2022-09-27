import 'package:quiz/src/domain/entities/quiz_parameters.dart';

import '../../api/api/api.dart';
import '../../core/either.dart';

class QuizParametersRepo {
  QuizParametersRepo({required this.api});

  final Api api;

  Future<Either<QuizParameters>> fetchParameters() async {
    final eitherParameters = await api.getQuizParameters();
    return eitherParameters;
  }
}
