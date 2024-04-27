import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mapfeature_project/movies/moviesmodel.dart';
import 'package:mapfeature_project/movies/api.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieDetails>(
      future: Api().getMovieDetails(movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Movie Details'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Movie Details'),
            ),
            body: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        } else {
          final movieDetails = snapshot.data!;
          return Scaffold(
            body: Stack(
              children: [
                // Background Image
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(movieDetails.posterUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Blurred Bottom Half
                Positioned.fill(
                  bottom: null,
                  top: MediaQuery.of(context).size.height / 2,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ),

                // Movie Details
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Movie Poster
                      Container(
                        height: 450,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(movieDetails.posterUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6.0, horizontal: 5),
                            child: Text(
                              movieDetails.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: "langar",
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: RatingBarIndicator(
                              rating: movieDetails.rating / 2,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 30.0,
                              direction: Axis.horizontal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Movie Overview
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Overview:',
                          style: TextStyle(
                            fontFamily: "langar",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          movieDetails.overview,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Movie Genres
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ' ${movieDetails.genres.join(", ")}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "langar",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Movie Duration
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Duration: ${movieDetails.duration}',
                          style: const TextStyle(
                            fontFamily: "langar",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Release Date
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              'Release Date: ',
                              style: TextStyle(
                                fontFamily: "langar",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              movieDetails.releaseDate,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
