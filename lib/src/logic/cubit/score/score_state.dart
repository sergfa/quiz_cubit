part of 'score_cubit.dart';

class ScoreState extends Equatable {
  final Map<int, int> categoriesScore;

  const ScoreState(
    this.categoriesScore,
  );

  factory ScoreState.fromMap(Map<String, dynamic> json) {
    final catToScore = <int, int>{};
    print('from map');
    print(json);
    if (json == null) {
      return null;
    }

    json.forEach((key, value) {
      catToScore[int.parse(key)] = value;
    });
    return ScoreState(catToScore);
  }

  Map<String, dynamic> toMap(ScoreState state) {
    print('to map');
    print(state);

    final json = <String, dynamic>{};
    state.categoriesScore.forEach((key, value) {
      json['$key'] = value;
    });
    return json;
  }

  @override
  List<Object> get props => [categoriesScore];
}
