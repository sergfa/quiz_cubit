import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class OpenTriviaCategoryItem {
  String name;
  int value;

  OpenTriviaCategoryItem({@required this.name, @required this.value});

  OpenTriviaCategoryItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  @override
  String toString() {
    return 'Name: $name, Value: $value';
  }
}

class OpenTriviaQuizItem extends Equatable {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final int correctAnswerIndex;
  final List<String> allAnswers;

  OpenTriviaQuizItem(
      {this.category,
      this.type,
      this.difficulty,
      this.question,
      this.correctAnswer,
      this.allAnswers,
      this.correctAnswerIndex});

  factory OpenTriviaQuizItem.fromMap(Map<String, dynamic> map) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    var correctAnswer = stringToBase64.decode(map['correct_answer']);
    var allAnswers = List<String>.from(map['incorrect_answers'])
        .map((e) => stringToBase64.decode(e))
        .toList();
    allAnswers.add(correctAnswer);
    allAnswers.shuffle();
    int correctAnswerIndex = 0;
    for (int i = 0; i < allAnswers.length; i++) {
      if (allAnswers[i] == correctAnswer) {
        correctAnswerIndex = i;
        break;
      }
    }
    return OpenTriviaQuizItem(
        category: stringToBase64.decode(map['category']),
        type: map['type'],
        difficulty: map['difficulty'],
        question: stringToBase64.decode(map['question']),
        correctAnswer: correctAnswer,
        allAnswers: allAnswers,
        correctAnswerIndex: correctAnswerIndex);
  }

  factory OpenTriviaQuizItem.fromJson(String source) =>
      OpenTriviaQuizItem.fromMap(json.decode(source));

  @override
  List<Object> get props =>
      [category, type, difficulty, question, correctAnswer, allAnswers];
}

class OpenTriviaFetchQuizResponse {
  int response_code;
  List<OpenTriviaQuizItem> results;

  OpenTriviaFetchQuizResponse({
    this.response_code,
    this.results,
  });

  factory OpenTriviaFetchQuizResponse.fromMap(Map<String, dynamic> map) {
    return OpenTriviaFetchQuizResponse(
      response_code: map['response_code'],
      results: List<OpenTriviaQuizItem>.from(
          map['results'].map((x) => OpenTriviaQuizItem.fromMap(x))),
    );
  }

  factory OpenTriviaFetchQuizResponse.fromJson(String source) =>
      OpenTriviaFetchQuizResponse.fromMap(json.decode(source));
}
