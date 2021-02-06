part of 'opentriviaquiz_cubit.dart';

abstract class OpenTriviaQuizState extends Equatable {
  const OpenTriviaQuizState();

  @override
  List<Object> get props => [];
}

class OpenTriviaQuizInitial extends OpenTriviaQuizState {}

class OpenTriviaQuizStartGame extends OpenTriviaQuizState {}

class OpenTriviaQuizLoading extends OpenTriviaQuizState {}

class OpenTriviaQuizLoadFailed extends OpenTriviaQuizState {
  final String errorMsg;

  OpenTriviaQuizLoadFailed({this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

class OpenTriviaQuizGameInProgress extends OpenTriviaQuizState {
  final List<OpenTriviaQuizItem> items;
  final int currentQuestion;
  final int score;
  final String mode;
  final int answerId;
  OpenTriviaQuizGameInProgress(
      {this.items, this.currentQuestion, this.score, @required this.mode, this.answerId});

  @override
  List<Object> get props => [items, currentQuestion, score, mode, answerId];

  OpenTriviaQuizGameInProgress copyWith(
      {List<OpenTriviaQuizItem> items,
      int currentQuestion,
      int score,
      String mode,
      int answerId}) {
    return OpenTriviaQuizGameInProgress(
        items: items ?? this.items,
        currentQuestion: currentQuestion ?? this.currentQuestion,
        score: score ?? this.score,
        mode: mode ?? this.mode,
        answerId: answerId ?? this.answerId);
  }
}
