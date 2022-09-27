import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/src/presenter/quiz/quiz_page.dart';
import 'package:quiz/src/presenter/quiz_choice/quiz_choice_cubit.dart';
import 'package:quiz/src/ui/widgets/circular_progress_indicator.dart';
import 'package:quiz/src/ui/widgets/show_error.dart';

import '../../domain/entities/quiz_parameters.dart';

class QuizChoicePage extends StatelessWidget {
  const QuizChoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizChoiceCubit(parametersRepo: context.read()),
      child: const _QuizChoicePageWidget(),
    );
  }
}

class _QuizChoicePageWidget extends StatelessWidget {
  const _QuizChoicePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyQuizChoicePage(),
    );
  }

  Widget _bodyQuizChoicePage() {
    return BlocConsumer<QuizChoiceCubit, QuizChoiceState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showError(context, state.error);
        }
      },
      buildWhen: (p, c) => c is LoadedState,
      builder: (context, state) {
        if (state is LoadedState) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Quiz',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Category:',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _categoriesWidget(state.quizParameters.categories),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('Difficulty:'),
                  const SizedBox(
                    height: 10,
                  ),
                  _difficultiesWidget(state.quizParameters.difficulties),
                  const SizedBox(
                    height: 30,
                  ),
                  _beginButton(context),
                ],
              ),
            ),
          );
        }
        return const Center(child: UICircularProgressIndicator());
      },
    );
  }

  Widget _categoriesWidget(List<Category> categories) {
    return BlocBuilder<QuizChoiceCubit, QuizChoiceState>(
      builder: (context, state) {
        return SizedBox(
          width: 200,
          child: DropdownButtonFormField<String>(
            items: categories.map((Category value) {
              return DropdownMenuItem<String>(
                value: value.nameCategory,
                child: Text(value.nameCategory),
              );
            }).toList(),
            value: context.read<QuizChoiceCubit>().category,
            onChanged: (value) {
              context
                  .read<QuizChoiceCubit>()
                  .onCategoryChanged(value == 'any' ? null : value);
            },
          ),
        );
      },
    );
  }

  Widget _difficultiesWidget(List<Difficulty> difficulties) {
    return BlocBuilder<QuizChoiceCubit, QuizChoiceState>(
      builder: (context, state) {
        return SizedBox(
          width: 200,
          child: DropdownButtonFormField<String>(
            items: difficulties.map((Difficulty value) {
              return DropdownMenuItem<String>(
                value: value.nameDifficulty,
                child: Text(value.nameDifficulty),
              );
            }).toList(),
            value: context.read<QuizChoiceCubit>().difficulty,
            onChanged: (value) {
              context
                  .read<QuizChoiceCubit>()
                  .onDifficultyChanged(value == 'any' ? null : value);
            },
          ),
        );
      },
    );
  }

  Widget _beginButton(BuildContext ctx) {
    return SizedBox(
      width: 200,
      child: CupertinoButton(
        color: Colors.blue,
        onPressed: () {
          Navigator.of(ctx).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => QuizPage(
                  category: ctx.read<QuizChoiceCubit>().category,
                  difficulty: ctx.read<QuizChoiceCubit>().difficulty,
                ),
              ),
              (Route<dynamic> route) => false);
        },
        child: const Text('Начать'),
      ),
    );
  }
}
