class QuizParameters {
  QuizParameters({
    required this.categories,
    required this.difficulties,
  });
  late final List<Category> categories;
  late final List<Difficulty> difficulties;

  QuizParameters.fromJson(Map<String, dynamic> json) {
    categories =
        List.from(json['categories']).map((e) => Category.fromJson(e)).toList();
    difficulties = List.from(json['difficulties'])
        .map((e) => Difficulty.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['categories'] = categories.map((e) => e.toJson()).toList();
    data['difficulties'] = difficulties.map((e) => e.toJson()).toList();
    return data;
  }
}

class Category {
  Category({
    required this.nameCategory,
  });
  late final String nameCategory;

  Category.fromJson(Map<String, dynamic> json) {
    nameCategory = json['nameCategory'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nameCategory'] = nameCategory;
    return data;
  }
}

class Difficulty {
  Difficulty({
    required this.nameDifficulty,
  });
  late final String nameDifficulty;

  Difficulty.fromJson(Map<String, dynamic> json) {
    nameDifficulty = json['nameDifficulty'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nameDifficulty'] = nameDifficulty;
    return data;
  }
}
