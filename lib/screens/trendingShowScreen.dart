// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/screens/watchShowScreen.dart';
import 'package:movie_app/utils/getTrending.dart';

class TrendingShowScreen extends StatefulWidget {
  const TrendingShowScreen({super.key});

  @override
  State<TrendingShowScreen> createState() => _TrendingShowScreenState();
}

class _TrendingShowScreenState extends State<TrendingShowScreen> {
  GetTrending getTrendingMoviesObj = GetTrending();

  @override
  void initState() {
    super.initState();
  }

  getShows() async {
    return getTrendingMoviesObj.getTrending("tv");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Trending Shows",
              style: GoogleFonts.quicksand(
                  fontSize: 30, fontWeight: FontWeight.w500),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.compare_arrows_rounded,
                weight: 0.1,
                size: 30,
              ),
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: getShows(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 0.65),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.length - 2,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WatchShowScreen(
                          id: snapshot.data[index].id,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data[index].posterPath}',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                );
              },
            );
          } else {
            children = SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return children;
        },
      ),
    );
  }
}
