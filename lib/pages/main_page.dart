import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '/views/movie_item.dart';
import '/helper/functions.dart';
import '/models/movie.dart';

class MoviePage extends StatefulWidget {
  static const String id = "moviePage";

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;
  bool hasRan = false;
  List<Movie> results = [];

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(23, 8, 42, 1),
        body: Stack(
          children: [
            Image.asset("assets/bg_bloop.png"),
            !hasRan
                ? SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: s.height*0.2),
                        Image.asset("assets/placeholder2.png"),
                        Text(
                          "Try searching for a Movie!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: s.width / 20,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                )
                : isLoading
                    ? const Center(child: CircularProgressIndicator(color: Colors.white))
                    : MovieItems(results)
            ,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.2),
                  borderRadius: BorderRadius.circular(15)),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search_rounded, color: Colors.white),
                    onPressed: () async {
                      if (_controller.text == "" || _controller.text == null) {
                        Fluttertoast.showToast(msg: "Invalid Input.");
                        return;
                      }

                      setState(() {
                        hasRan = true;
                        isLoading = true;
                      });
                      movieSetter(_controller.text).then((value) {
                        print(value);
                        setState(() {
                          results = value;
                          isLoading = false;
                        });
                      });
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close_outlined, color: Colors.white),
                    onPressed: () {
                      _controller.text = "";
                    },
                  ),
                ),
                controller: _controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
