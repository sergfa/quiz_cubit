import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_cubit/src/logic/cubit/score/score_cubit.dart';
import 'package:quiz_cubit/src/presentation/route/app_route.dart';
import 'package:quiz_cubit/src/presentation/screens/home_screen.dart';

class App extends StatelessWidget {
  final AppRouter appRouter;
  App({@required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScoreCubit>(
      create: (BuildContext context) => ScoreCubit(),
      child: MaterialApp(
        title: 'Quiz Cubit',
        theme: ThemeData.light().copyWith(
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
          primaryColor: Color(0xff689F38),
          accentColor: Color(0xff4CAF50),
        ),
        home: HomeScreen(),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
