import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/src/presenter/quiz/quiz_cubit.dart';
import 'package:quiz/src/presenter/quiz_result/quiz_result_page.dart';
import 'package:quiz/src/ui/widgets/circular_progress_indicator.dart';

import '../../domain/entities/quiz.dart';
import '../../ui/widgets/show_error.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key, required this.category, required this.difficulty})
      : super(key: key);

  final String? category;
  final String? difficulty;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizCubit(
          quizRepo: context.read(), category: category, difficulty: difficulty),
      child: const _QuizPageWidget(),
    );
  }
}

class _QuizPageWidget extends StatelessWidget {
  const _QuizPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _quizPageBody(context),
    );
  }

  Widget _quizPageBody(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showError(context, state.error);
          Navigator.of(context).pop();
        }
        if (state is EndState) {
          Navigator.of(context).pushAndRemoveUntil<void>(
              MaterialPageRoute(
                builder: (ctx) => QuizResultPage(
                  result: state.result,
                ),
              ),
              (Route<dynamic> route) => false);
        }
      },
      buildWhen: (p, c) => c is LoadedState,
      builder: (context, state) {
        if (state is LoadedState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: _cardWidget(state.quiz),
            ),
          );
        }
        return const Center(child: UICircularProgressIndicator());
      },
    );
  }

  Widget _cardWidget(List<Quiz> quiz) {
    return BlocBuilder<QuizCubit, QuizState>(
      buildWhen: (p, c) => c is! EndState,
      builder: (context, state) {
        final quizItem = quiz[context.read<QuizCubit>().question];
        return Column(
          children: [
            Text(quizItem.question),
            const SizedBox(
              height: 10,
            ),
            _answersWidget(quizItem.answers, quizItem.correctAnswers, context),
          ],
        );
      },
    );
  }

  Widget _answersWidget(
      Answers answers, CorrectAnswers correctAnswers, BuildContext ctx) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        _answer(answers.answerA,
            correctAnswers.answerACorrect.toLowerCase() == 'true', ctx),
        _answer(answers.answerB,
            correctAnswers.answerBCorrect.toLowerCase() == 'true', ctx),
        _answer(answers.answerC,
            correctAnswers.answerCCorrect.toLowerCase() == 'true', ctx),
        _answer(answers.answerD,
            correctAnswers.answerDCorrect.toLowerCase() == 'true', ctx),
        _answer(answers.answerE,
            correctAnswers.answerECorrect.toLowerCase() == 'true', ctx),
        _answer(answers.answerF,
            correctAnswers.answerFCorrect.toLowerCase() == 'true', ctx),
      ],
    );
  }

  Widget _answer(String? answer, bool correct, BuildContext ctx) {
    return answer != null
        ? GestureDetector(
            onTap: () => ctx.read<QuizCubit>().onQuestionChanged(correct),
            child: Container(
              margin: const EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(answer),
            ),
          )
        : const SizedBox();
  }
}
