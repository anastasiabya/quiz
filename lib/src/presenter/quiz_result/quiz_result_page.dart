import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../quiz_choice/quiz_choice_page.dart';
import 'quiz_result_cubit.dart';

import '../../domain/entities/result.dart';
import '../../ui/widgets/show_error.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({Key? key, required this.result}) : super(key: key);

  final Result result;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizResultCubit(
        result: result,
        resultRepo: context.read(),
      ),
      child: const _QuizResultPageWidget(),
    );
  }
}

class _QuizResultPageWidget extends StatelessWidget {
  const _QuizResultPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _quizResultBody(),
    );
  }

  Widget _quizResultBody() {
    return BlocConsumer<QuizResultCubit, QuizResultState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showError(context, state.error);
        }
        if (state is SuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        final result = context.read<QuizResultCubit>().result;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Category: ${result.category}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Difficulty: ${result.difficulty}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Correct answers: ${result.correctAnswers}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Incorrect answers: ${result.incorrectAnswers}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (state is! SuccessState)
                  SizedBox(
                    width: 200,
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      color: Colors.blue,
                      onPressed: () {
                        context.read<QuizResultCubit>().onSaveTap();
                      },
                      child: const Text('Сохранить'),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const QuizChoicePage(),
                          ),
                          (Route<dynamic> route) => false);
                    },
                    child: const Text('К выбору'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
