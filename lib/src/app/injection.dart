import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/repo/quiz_parameters_repo.dart';
import '../domain/repo/result_repo.dart';

import '../api/api/api.dart';
import '../domain/repo/quiz_repo.dart';

Future<Widget> injector(Widget app) async {
  await Firebase.initializeApp();

  final api = Api();

  final quizParameters = QuizParametersRepo(api: api);
  final quiz = QuizRepo(api: api);
  final result = ResultRepo(api: api);

  return MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (_) => quizParameters),
      RepositoryProvider(create: (_) => quiz),
      RepositoryProvider(create: (_) => result),
    ],
    child: app,
  );
}
