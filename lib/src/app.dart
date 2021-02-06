import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_cubit/src/presentation/route/app_route.dart';
import 'package:quiz_cubit/src/presentation/screens/home_screen.dart';

class App extends StatefulWidget {
  final AppRouter appRouter;
  App({@required this.appRouter});
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Cubit',
      theme: ThemeData.light().copyWith(
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme)),
      home: HomeScreen(),
      onGenerateRoute: widget.appRouter.onGenerateRoute,
    );
  }
}
