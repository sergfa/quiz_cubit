import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_cubit/src/constants/constants.dart';
import 'package:quiz_cubit/src/data/providers/open_trivia_quiz_provider.dart';
import 'package:quiz_cubit/src/logic/cubit/opentriviaquiz_cubit.dart';
import 'package:quiz_cubit/src/presentation/screens/about_screen.dart';
import 'package:quiz_cubit/src/presentation/screens/categoreis_screen.dart';
import 'package:quiz_cubit/src/presentation/screens/home_screen.dart';
import 'package:quiz_cubit/src/presentation/screens/play_screen.dart';
import 'package:quiz_cubit/src/presentation/screens/score_screen.dart';
import 'package:quiz_cubit/src/presentation/screens/settings_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.HOME:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case RouteNames.CATEGOREIS:
        return MaterialPageRoute(builder: (_) {
          var openTriviaQuizProvider = GetIt.instance<OpenTriviaQuizProvider>();
          return CategoriesScreen(openTriviaQuizProvider.categories);
        });
      case RouteNames.PLAY:
        var args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<OpenTriviaQuizCubit>(
            create: (_) => OpenTriviaQuizCubit(),
            child: PlayScreen(
              category: args['category'],
              amount: args['amount'],
              type: args['type'],
            ),
          ),
        );
      case RouteNames.ABOUT:
        return MaterialPageRoute(
          builder: (_) => AboutScreen(
            title: 'About Screen',
          ),
        );

      case RouteNames.SETTINGS:
        return MaterialPageRoute(
          builder: (_) => SettingsScreen(
            title: 'Settings Screen',
          ),
        );
      case RouteNames.SCORE:
        return MaterialPageRoute(
          builder: (_) => ScoreScreen(
            title: 'Score Screen',
          ),
        );

      default:
        return null;
    }
  }
}
