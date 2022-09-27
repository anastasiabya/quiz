import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/src/domain/repo/result_repo.dart';

import '../../domain/entities/result.dart';

abstract class QuizResultState {
  const QuizResultState();
}

class LoadingState extends QuizResultState {
  const LoadingState();
}

class SuccessState extends QuizResultState {
  const SuccessState({required this.message});

  final String message;
}

class ErrorState extends QuizResultState {
  const ErrorState({required this.error});

  final Exception error;
}

class QuizResultCubit extends Cubit<QuizResultState> {
  QuizResultCubit({required this.result, required this.resultRepo})
      : super(const LoadingState()) {
    initilize();
  }

  final Result result;
  final ResultRepo resultRepo;

  Future<void> initilize() async {
    emit(const LoadingState());
  }

  Future<void> onSaveTap() async {
    final resultUpload = await resultRepo.uploadResult(result: result);
    if (resultUpload.success) {
      emit(const SuccessState(message: 'Сохранено'));
    } else {
      emit(ErrorState(error: resultUpload.error!));
    }
  }
}
