import '../../core/either.dart';
import '../entities/quiz.dart';

import '../../api/api/api.dart';

class QuizRepo {
  QuizRepo({required this.api});

  final Api api;

  Future<Either<List<Quiz>>> fetchQuiz(
      {String? category, String? difficulty}) async {
    final eitherQuiz =
        await api.getQuiz(category: category, difficulty: difficulty);
    return eitherQuiz;
  }
}
