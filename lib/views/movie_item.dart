import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shimmer/shimmer.dart';
import '/helper/functions.dart';
import '/models/movie.dart';
import '/views/movie_detail_view.dart';

class MovieItems extends StatelessWidget {
  List<Movie> movieList;

  MovieItems(this.movieList);

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: s.height / 5, bottom: 20),
      child: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (c) {
                return MovieDetails(movieList[index]);
              }));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: movieList[index].poster!,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: s.height * 0.3,
                                width: s.width,
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/placeholder.png",
                              height: s.height * 0.3,
                              width: s.width,
                              fit: BoxFit.cover,
                            ),
                            height: s.height * 0.3,
                            width: s.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 25,
                        left: 10,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 0, 0, 0.6),
                              borderRadius: BorderRadius.circular(100)),
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.white, size: 15),
                              const SizedBox(width: 5),
                              Text(
                                "${movieList[index].imdb}/10",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    movieList[index].title!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: s.width / 25,
                        fontFamily:
                            Theme.of(context).textTheme.headline1!.fontFamily,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.amber[800],
                        size: 15,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        durationParser(movieList[index].runTime!.split(" ")[0]),
                        style: TextStyle(
                            color: Colors.amber[800],
                            fontFamily: Theme.of(context)
                                .textTheme
                                .headline1!
                                .fontFamily,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
