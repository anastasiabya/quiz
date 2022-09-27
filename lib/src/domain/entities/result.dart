import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Result {
  Result(
      {required this.time,
      required this.category,
      required this.correctAnswers,
      required this.incorrectAnswers,
      required this.difficulty});
  final Timestamp time;
  final String category;
  final String difficulty;
  final int correctAnswers;
  final int incorrectAnswers;

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'category': category,
      'difficulty': difficulty,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      time: Timestamp.fromDate(map['time']),
      category: map['category'] ?? '',
      difficulty: map['difficulty'] ?? '',
      correctAnswers: map['correctAnswers']?.toInt() ?? 0,
      incorrectAnswers: map['incorrectAnswers']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) => Result.fromMap(json.decode(source));
}
