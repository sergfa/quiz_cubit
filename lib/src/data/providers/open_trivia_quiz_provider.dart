import 'dart:async' show Future;

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:quiz_cubit/src/data/models/open_trivia_models.dart';

class OpenTriviaQuizProvider {
  final List<OpenTriviaCategoryItem> categories;

  OpenTriviaQuizProvider({@required this.categories});

  static const API_URL = 'opentdb.com';

  Future<http.Response> fetchQuiz(
      {int category, String difficulty, String type, @required int amount}) {
    Map<String, String> queryParams =
        _createFetchQuizQueryParamMap(amount, category, difficulty, type);
    var uri = Uri.https(API_URL, 'api.php', queryParams);
    return http.get(uri);
  }

  Map<String, String> _createFetchQuizQueryParamMap(
      int amount, int category, String difficulty, String type) {
    Map<String, String> queryParams = {};
    queryParams['amount'] = amount.toString();

    if (category != null && category > 0) {
      queryParams['category'] = category.toString();
    }
    if (difficulty != null) {
      queryParams['difficulty'] = difficulty;
    }

    if (type != null) {
      queryParams['type'] = type;
    }
    queryParams['encode'] = 'base64';
    return queryParams;
  }
}
