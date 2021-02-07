import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'score_state.dart';

class ScoreCubit extends Cubit<ScoreState> with HydratedMixin {
  ScoreCubit() : super(ScoreState(<int,int>{}));

  void updateScore(int category, int score) {
    final currentScore = state.categoriesScore[category] ?? 0;
    if (score > currentScore) {
      final newMap =Map<int, int>.from(state.categoriesScore);
      newMap[category] = score;
      emit(ScoreState(newMap));
    }
  }

  @override
  ScoreState fromJson(Map<String, dynamic> json) {
    return ScoreState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(ScoreState state) {
    return state.toMap(state);
  }
}
