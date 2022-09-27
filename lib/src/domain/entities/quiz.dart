class Quiz {
  Quiz({
    required this.id,
    required this.question,
    required this.answers,
    required this.multipleCorrectAnswers,
    required this.correctAnswers,
    required this.correctAnswer,
    required this.tags,
    required this.category,
    required this.difficulty,
  });
  late final int id;
  late final String question;
  late final Answers answers;
  late final String multipleCorrectAnswers;
  late final CorrectAnswers correctAnswers;
  late final String? correctAnswer;
  late final List<Tags> tags;
  late final String category;
  late final String difficulty;

  Quiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answers = Answers.fromJson(json['answers']);
    multipleCorrectAnswers = json['multiple_correct_answers'];
    correctAnswers = CorrectAnswers.fromJson(json['correct_answers']);
    correctAnswer = json['correct_answer'];
    tags = List.from(json['tags']).map((e) => Tags.fromJson(e)).toList();
    category = json['category'];
    difficulty = json['difficulty'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answers'] = answers.toJson();
    data['multiple_correct_answers'] = multipleCorrectAnswers;
    data['correct_answers'] = correctAnswers.toJson();
    data['correct_answer'] = correctAnswer;
    data['tags'] = tags.map((e) => e.toJson()).toList();
    data['category'] = category;
    data['difficulty'] = difficulty;
    return data;
  }
}

class Answers {
  Answers({
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
    required this.answerE,
    required this.answerF,
  });
  late final String? answerA;
  late final String? answerB;
  late final String? answerC;
  late final String? answerD;
  late final String? answerE;
  late final String? answerF;

  Answers.fromJson(Map<String, dynamic> json) {
    answerA = json['answer_a'];
    answerB = json['answer_b'];
    answerC = json['answer_c'];
    answerD = json['answer_d'];
    answerE = json['answer_e'];
    answerF = json['answer_f'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['answer_a'] = answerA;
    data['answer_b'] = answerB;
    data['answer_c'] = answerC;
    data['answer_d'] = answerD;
    data['answer_e'] = answerE;
    data['answer_f'] = answerF;
    return data;
  }
}

class CorrectAnswers {
  CorrectAnswers({
    required this.answerACorrect,
    required this.answerBCorrect,
    required this.answerCCorrect,
    required this.answerDCorrect,
    required this.answerECorrect,
    required this.answerFCorrect,
  });
  late final String answerACorrect;
  late final String answerBCorrect;
  late final String answerCCorrect;
  late final String answerDCorrect;
  late final String answerECorrect;
  late final String answerFCorrect;

  CorrectAnswers.fromJson(Map<String, dynamic> json) {
    answerACorrect = json['answer_a_correct'];
    answerBCorrect = json['answer_b_correct'];
    answerCCorrect = json['answer_c_correct'];
    answerDCorrect = json['answer_d_correct'];
    answerECorrect = json['answer_e_correct'];
    answerFCorrect = json['answer_f_correct'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['answer_a_correct'] = answerACorrect;
    data['answer_b_correct'] = answerBCorrect;
    data['answer_c_correct'] = answerCCorrect;
    data['answer_d_correct'] = answerDCorrect;
    data['answer_e_correct'] = answerECorrect;
    data['answer_f_correct'] = answerFCorrect;
    return data;
  }
}

class Tags {
  Tags({
    required this.name,
  });
  late final String name;

  Tags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
