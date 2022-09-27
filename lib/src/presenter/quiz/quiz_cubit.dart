import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/src/domain/entities/quiz.dart';
import 'package:quiz/src/domain/entities/result.dart';

import '../../domain/repo/quiz_repo.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class LoadingState extends QuizState {
  const LoadingState();
}

class LoadedState extends QuizState {
  const LoadedState({required this.quiz});

  final List<Quiz> quiz;
}

class QuestionChanged extends QuizState {
  const QuestionChanged({
    required this.question,
  });

  final int? question;

  @override
  List<Object?> get props => [question];
}

class EndState extends QuizState {
  const EndState({
    required this.result,
  });

  final Result result;
}

class ErrorState extends QuizState {
  const ErrorState({required this.error});

  final Exception error;
}

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(
      {required this.quizRepo,
      required this.category,
      required this.difficulty})
      : super(const LoadingState()) {
    initilize();
  }

  final QuizRepo quizRepo;
  final String? category;
  final String? difficulty;

  int question = 0;
  int correctAnswers = 0;
  late final int questionCount;

  Future<void> initilize() async {
    emit(const LoadingState());
    final quiz =
        await quizRepo.fetchQuiz(category: category, difficulty: difficulty);
    if (quiz.success) {
      questionCount = quiz.data!.length;
      emit(LoadedState(quiz: quiz.data!));
    } else {
      emit(ErrorState(error: quiz.error!));
    }
  }

  void onQuestionChanged(bool correct) {
    if (correct) correctAnswers++;
    question++;
    question > 9 || question >= questionCount
        ? emit(
            EndState(
              result: Result(
                category: category ?? 'any',
                correctAnswers: correctAnswers,
                incorrectAnswers: questionCount - correctAnswers,
                difficulty: difficulty ?? 'any',
                time: Timestamp.now(),
              ),
            ),
          )
        : emit(QuestionChanged(question: question));
  }
}
