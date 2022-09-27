import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/quiz_parameters.dart';
import '../../domain/repo/quiz_parameters_repo.dart';

abstract class QuizChoiceState extends Equatable {
  const QuizChoiceState();

  @override
  List<Object?> get props => [];
}

class LoadingState extends QuizChoiceState {
  const LoadingState();
}

class LoadedState extends QuizChoiceState {
  const LoadedState({required this.quizParameters});

  final QuizParameters quizParameters;
}

class CategoryChanged extends QuizChoiceState {
  const CategoryChanged({
    required this.category,
  });

  final String? category;

  @override
  List<Object?> get props => [category];
}

class DifficultyChanged extends QuizChoiceState {
  const DifficultyChanged({
    required this.difficulty,
  });

  final String? difficulty;

  @override
  List<Object?> get props => [difficulty];
}

class ErrorState extends QuizChoiceState {
  const ErrorState({required this.error});

  final Exception error;
}

class QuizChoiceCubit extends Cubit<QuizChoiceState> {
  QuizChoiceCubit({required this.parametersRepo})
      : super(const LoadingState()) {
    initilize();
  }

  final QuizParametersRepo parametersRepo;

  String? category;
  String? difficulty;

  Future<void> initilize() async {
    emit(const LoadingState());
    final quizParameters = await parametersRepo.fetchParameters();
    if (quizParameters.success) {
      emit(LoadedState(quizParameters: quizParameters.data!));
    } else {
      emit(ErrorState(error: quizParameters.error!));
    }
  }

  void onCategoryChanged(String? ctg) {
    category = ctg;
    emit(CategoryChanged(category: category));
  }

  void onDifficultyChanged(String? dif) {
    difficulty = dif;
    emit(DifficultyChanged(difficulty: difficulty));
  }
}
