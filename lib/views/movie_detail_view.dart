import 'package:flutter/material.dart';
import 'package:movie_search/views/TextBlockMovie.dart';
import '/models/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetails extends StatelessWidget {
  Movie movie;

  MovieDetails(this.movie);

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery
        .of(context)
        .size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(23, 8, 42, 1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: CachedNetworkImage(
                        imageUrl: movie.poster!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: SizedBox(
                                height: s.height * 0.6,
                                width: s.width,
                              ),
                            ),
                        errorWidget: (context, url, error) =>
                            Image.asset(
                              "assets/placeholder.png",
                              height: s.height * 0.6,
                              width: s.width,
                              fit: BoxFit.cover,
                            ),
                        height: s.height * 0.6,
                        width: s.width,
                        fit: BoxFit.cover,
                      )),
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.4),
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white)),
                  ),
                  Positioned(
                      bottom: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            width: s.width * 0.7,
                            child: Text(
                              movie.title!,
                              style: TextStyle(
                                fontSize: s.width / 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            width: s.width * 0.8,
                            child: Text(
                              movie.genres!,
                              style: TextStyle(
                                fontSize: s.width / 27,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 20),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.05),
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_downward_outlined,
                            color: Colors.white)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.05),
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border,
                            color: Colors.white)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.05),
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      onPressed: () {},
                      icon: const ImageIcon(
                          AssetImage("assets/arrow_forward.png"),
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.05),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: s.width * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 30,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount:
                                  (double.parse(movie.imdb!) / 2).floor(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Icon(Icons.star,
                                        color: Colors.amber[600]);
                                  },
                                ),
                              ),
                              double.parse(movie.imdb!) -
                                  double.parse(movie.imdb!).floor() != 0
                                  ? SizedBox(
                                height: 30,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Icon(Icons.star_half_rounded,
                                        color: Colors.amber[600]);
                                  },
                                ),
                              )
                                  : const SizedBox(),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Internet Movie Database",
                            style: TextStyle(
                                color: Colors.grey, fontSize: s.width / 22),
                          ),
                          Text(
                            "Rotten Tomatoes",
                            style: TextStyle(
                                color: Colors.grey, fontSize: s.width / 22),
                          ),
                          Text(
                            "Metacritic",
                            style: TextStyle(
                                color: Colors.grey, fontSize: s.width / 22),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            movie.imdb!,
                            style: TextStyle(
                                color: Colors.amber[800],
                                fontWeight: FontWeight.bold,
                                fontSize: s.width / 22),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "${movie.imdb!}/10",
                            style: TextStyle(
                                color: Colors.grey, fontSize: s.width / 22),
                          ),
                          Text(
                            movie.metaCritic == "N/A"
                                ? movie.metaCritic!
                                : "${movie.metaCritic!}%",
                            style: TextStyle(
                                color: Colors.grey, fontSize: s.width / 22),
                          ),
                          Text(
                            movie.metascore == null
                                ? "N/A"
                                : "${movie.metascore}/100",
                            style: TextStyle(
                                color: Colors.grey, fontSize: s.width / 22),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.05),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/calendar.png",
                          width: s.width * 0.04,
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: s.width * 0.6,
                          child: Text(
                            movie.year!,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: s.width / 22
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/globe.png",
                          width: s.width * 0.04,
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: s.width * 0.6,
                          child: Text(
                            movie.country!,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: s.width / 22
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/clock.png",
                          width: s.width * 0.04,
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: s.width * 0.6,
                          child: Text(
                            movie.runTime!,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: s.width / 22
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/sound.png",
                          width: s.width * 0.04,
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: s.width * 0.6,
                          child: Text(
                            movie.languages!,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: s.width / 22
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.05),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Plot",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: s.width / 20
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "\"${movie.plot}\"",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: s.width / 25
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Director",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: s.width / 20
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: movie.directors!.split(",").map((e) {
                          return TextBoxCustom(e);
                        }).toList()
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Actors",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: s.width / 20
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: movie.actors!.split(",").map((e) {
                          return TextBoxCustom(e);
                        }).toList()
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Writer",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: s.width / 20
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: movie.writers!.split(",").map((e) {
                          return TextBoxCustom(e);
                        }).toList()
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
