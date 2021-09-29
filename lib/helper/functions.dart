import 'dart:convert';
import 'package:http/http.dart';
import '/models/movie.dart';

const String myKey = "58f64034";

String durationParser(String duration){

  if(duration=="N/A"){
    return duration;
  }

  int minutes = int.parse(duration)%60;
  int hours = (int.parse(duration)/60).floor();

  return hours<=0
      ? "$minutes minutes"
      : "$hours hours $minutes minutes";
}

Future<List<Movie>> movieSetter(String query)async{
  Map m1 = await searchByText(query);
  List l1 = m1["Search"];
  List <Movie>finalResult = [];
  for(var element in l1){
    String imdbID = element["imdbID"];
    final res = await searchByID(imdbID);
    Movie m1 = Movie.fromJSON(res);
    finalResult.add(m1);
  }

  return finalResult;
}

Future<Map> searchByText(String query) async {
  final response =
  await get(Uri.parse("https://www.omdbapi.com/?apikey=$myKey&s=$query"));

  return jsonDecode(response.body);
}

Future<Map> searchByID(String id) async {
  final response =
  await get(Uri.parse("https://www.omdbapi.com/?apikey=$myKey&i=$id"));

  return jsonDecode(response.body);
}