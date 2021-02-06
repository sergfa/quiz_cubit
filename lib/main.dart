import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_cubit/src/app.dart';
import 'package:quiz_cubit/src/data/models/open_trivia_models.dart';
import 'package:quiz_cubit/src/data/providers/open_trivia_quiz_provider.dart';
import 'package:quiz_cubit/src/presentation/route/app_route.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  setupServices();
  var appRouter = AppRouter();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(App(
    appRouter: appRouter,
  ));
}

Future<List<OpenTriviaCategoryItem>> createOpenTriviaCategories() async {
  var categories = <OpenTriviaCategoryItem>[];
  var jsonText =
      await rootBundle.loadString('assets/open_trivia/categories.json');
  List<dynamic> categoriesJson = json.decode(jsonText);
  categoriesJson.forEach((element) {
    categories.add(OpenTriviaCategoryItem.fromJson(element));
  });
  return categories;
}

void setupServices() async {
  var categories = await createOpenTriviaCategories();
  GetIt.I.registerSingleton<OpenTriviaQuizProvider>(
    OpenTriviaQuizProvider(categories: categories),
  );
}
