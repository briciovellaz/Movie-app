import 'package:flutter/material.dart';
import 'movie.dart';
import 'movie_like_counter.dart';
import 'movie_secondary_button.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () {
            //go back
          },
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image:
                      AssetImage('assets/images/${widget.movie.backdrop}.jpg'),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        widget.movie.title,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.movie.originalTitle,
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ), //title
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: OutlinedButton.icon(
                          onPressed: () {
                            //Play trailer
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          icon: Icon(
                            Icons.play_arrow,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          label: Text(
                            'Play Trailer',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(
                            widget.movie.releaseDate,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ), //play trailer button and release date info
                Row(
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SecondaryButton(icon: Icons.list),
                          SecondaryButton(icon: Icons.bookmark_border),
                          SecondaryButton(icon: Icons.star_border),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          LikeCounter(
                            counter: _counter,
                          ),
                          Text(
                            'Avg. vote: ${widget.movie.voteAverage}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ), // list, save and star buttons, like-counter
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    //genres
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Genres',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: 25,
                          child: ListView.builder(
                              itemCount: widget.movie.genres.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: Text(
                                      widget.movie.genres[index],
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ), //genres
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Overview',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ), //overview title
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        widget.movie.overview,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ), //overview description
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
        },
        child: const Icon(
          Icons.thumb_up_alt_sharp,
        ),
      ),
    );
  }
}
