import 'package:get_it/get_it.dart';
import 'package:quiz_cubit/src/data/models/open_trivia_models.dart';
import 'package:quiz_cubit/src/data/providers/open_trivia_quiz_provider.dart';
import 'package:meta/meta.dart';

class OpenTriviaQuizRepository {
  OpenTriviaQuizProvider openTriviaQuizProvider;

  OpenTriviaQuizRepository() {
    openTriviaQuizProvider = GetIt.instance<OpenTriviaQuizProvider>();
  }

  Future<List<OpenTriviaQuizItem>> fetchQuiz(
      {int category,
      String difficulty,
      String type,
      @required int amount}) async {
    final response = await openTriviaQuizProvider.fetchQuiz(
      amount: amount,
      category: category,
      difficulty: difficulty,
      type: type,
    );
    if (response.statusCode == 200) {
      final openTriviaFetchQuizResponse =
          OpenTriviaFetchQuizResponse.fromJson(response.body);
      if (openTriviaFetchQuizResponse.response_code == 0) {
        return openTriviaFetchQuizResponse.results;
      }
    }
    throw Exception();
  }

  Map<int, int> createCategoriesToScoreMap() {
    final Map<int, int> catToScore = {};
    openTriviaQuizProvider.categories.forEach((element) {
      catToScore.putIfAbsent(element.value, () => 0);
    });
    return catToScore;
  }
}
