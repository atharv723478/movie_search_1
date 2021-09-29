import 'package:flutter/material.dart';
import 'package:movie_search/pages/main_page.dart';
import 'package:provider/provider.dart';
import 'models/movie.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Movie()),
    ],
    child: MaterialApp(
      theme: ThemeData(
          fontFamily: "Whitney",
          textTheme: const TextTheme(
            headline1: TextStyle(fontFamily: "Whitney")
          )
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: MoviePage.id,
      routes: {MoviePage.id: (context) => MoviePage()},
    ),
  ));
}
