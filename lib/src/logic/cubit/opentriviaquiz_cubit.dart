import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:quiz_cubit/src/constants/open_trivia/open_trivia_constants.dart';
import 'package:quiz_cubit/src/data/models/open_trivia_models.dart';
import 'package:quiz_cubit/src/data/repositories/open_trivia_quiz_repository.dart';

part 'opentriviaquiz_state.dart';

class OpenTriviaQuizCubit extends Cubit<OpenTriviaQuizState> {
  OpenTriviaQuizCubit() : super(OpenTriviaQuizInitial());

  void fetchQuiz(
      {int category,
      String difficulty,
      String type,
      @required int amount}) async {
    emit(OpenTriviaQuizLoading());
    var repository = OpenTriviaQuizRepository();
    try {
      var data = await repository.fetchQuiz(
          amount: amount,
          category: category,
          difficulty: difficulty,
          type: type);
      emit(OpenTriviaQuizGameInProgress(
          items: data,
          score: 0,
          currentQuestion: 0,
          mode: OpenTriviaGameInProgressMode.LOADED,
          answerId: -1));
    } catch (e) {
      print(e.toString());
      emit(OpenTriviaQuizLoadFailed(errorMsg: e.toString()));
    }
  }

  void gameStarted() {
    var myState = state as OpenTriviaQuizGameInProgress;
    emit(myState.copyWith(mode: OpenTriviaGameInProgressMode.STARTED));
  }

  void correctAnswer(int answerId) {
    var myState = state as OpenTriviaQuizGameInProgress;
    emit(
      myState.copyWith(
          score: myState.score + 10,
          mode: OpenTriviaGameInProgressMode.CORRECT_ANSWER,
          answerId: answerId),
    );
  }

  void wrongAnswer(int answerId) {
    var myState = state as OpenTriviaQuizGameInProgress;
    emit(myState.copyWith(
        mode: OpenTriviaGameInProgressMode.WRONG_ANSWER, answerId: answerId));
  }

  void nextQuestion() {
    var myState = state as OpenTriviaQuizGameInProgress;
    emit(myState.copyWith(
        mode: OpenTriviaGameInProgressMode.STARTED,
        currentQuestion: myState.currentQuestion + 1));
  }

  void endGame() {
    var myState = state as OpenTriviaQuizGameInProgress;
    emit(myState.copyWith(mode: OpenTriviaGameInProgressMode.END_GAME));
  }

  void startQuiz() {
    emit(OpenTriviaQuizStartGame());
  }
}
