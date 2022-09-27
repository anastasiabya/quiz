import 'dart:convert';

import '../../domain/entities/quiz.dart';

import '../../core/either.dart';
import '../../domain/entities/quiz_parameters.dart';
import '../../domain/entities/result.dart';
import '../base_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class Api extends BaseApi
    with QuizParametersRequest, QuizRequest, UploadResultRequest {
  Api();
}

mixin QuizParametersRequest on BaseApi {
  Future<Either<QuizParameters>> getQuizParameters() async {
    QuizParameters quizParameters = QuizParameters(categories: [
      Category(nameCategory: 'any'),
      Category(nameCategory: 'linux'),
      Category(nameCategory: 'bash'),
      Category(nameCategory: 'uncategorized'),
      Category(nameCategory: 'docker'),
      Category(nameCategory: 'sql'),
      Category(nameCategory: 'cms'),
      Category(nameCategory: 'code'),
      Category(nameCategory: 'devops'),
    ], difficulties: [
      Difficulty(nameDifficulty: 'any'),
      Difficulty(nameDifficulty: 'Easy'),
      Difficulty(nameDifficulty: 'Medium'),
      Difficulty(nameDifficulty: 'Hard'),
    ]);
    try {} on Exception catch (e) {
      return Either.error(e);
    }
    return Either.success(quizParameters);
  }
}

mixin QuizRequest on BaseApi {
  Future<Either<List<Quiz>>> getQuiz(
      {String? category, String? difficulty}) async {
    List<Quiz> quiz = <Quiz>[];

    var url =
        'https://quizapi.io/api/v1/questions?apiKey=j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa&limit=10${category == null ? '' : '&category=$category'}${difficulty == null ? '' : '&difficulty=$difficulty'}';

    try {
      http.Response? response;
      response = await http.get(
        Uri.parse(url),
      );
      var dataQuiz = jsonDecode(response.body) as List;
      quiz = dataQuiz.map((json) => Quiz.fromJson(json)).toList();
    } on Exception catch (e) {
      return Either.error(e);
    }
    return Either.success(quiz);
  }
}

mixin UploadResultRequest on BaseApi {
  Future<Either<void>> uploadResult({required Result result}) async {
    try {
      await FirebaseFirestore.instance
          .collection("results")
          .add(result.toMap());
    } on Exception catch (_) {
      return Either.error(Exception('Error uploading'));
    }
    return const Either.success(null);
  }
}
