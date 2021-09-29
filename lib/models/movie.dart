import 'package:flutter/material.dart';

class Movie with ChangeNotifier {
  String? title;
  String? poster;
  String? genres;
  String? imdb;
  String? rottenTomatoes;
  String? metascore;
  String? metaCritic;
  String? year;
  String? country;
  String? runTime;
  String? languages;
  String? plot;
  String? directors;
  String? actors;
  String? writers;
  Map? data;

  Movie({this.title,
    this.year,
    this.actors,
    this.country,
    this.directors,
    this.genres,
    this.imdb,
    this.languages,
    this.metaCritic,
    this.plot,
    this.metascore,
    this.poster,
    this.rottenTomatoes,
    this.runTime,
    this.writers,
    this.data});

  List<Movie> _movies = [];

  List<Movie> get movies => [..._movies];

  void setNewList(List<Movie> the_movie) {
    _movies = the_movie;
    notifyListeners();
  }

  factory Movie.fromJSON(Map data) {
    List ratings = data["Ratings"];
    String rottenTomatoes = "";

    ratings.forEach((element) {
      if (element["Source"] == "Rotten Tomatoes") {
        rottenTomatoes = element["Value"];
      }
    });

    return Movie(
      metascore: data["Metascore"],
      data: data,
      title: data["Title"],
      poster: data["Poster"],
      genres: data["Genre"],
      imdb: data["imdbRating"],
      rottenTomatoes: rottenTomatoes,
      metaCritic: data["Metascore"],
      year: data["Year"],
      country: data["Country"],
      runTime: data["Runtime"],
      languages: data["Language"],
      plot: data["Plot"],
      directors: data["Director"],
      actors: data["Actors"],
      writers: data["Writer"],
    );
  }
}
