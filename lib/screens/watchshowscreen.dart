import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/models/showmodel.dart';
import 'package:movie_app/utils/getcast.dart';
import 'package:movie_app/utils/getshows.dart';

class WatchShowScreen extends StatefulWidget {
  final int id;

  const WatchShowScreen({
    super.key,
    required this.id,
  });

  @override
  State<WatchShowScreen> createState() => _WatchShowScreenState();
}

class _WatchShowScreenState extends State<WatchShowScreen> {
  GetCast getCastObj = GetCast();
  GetShows getShowsObj = GetShows();
  ShowModel? currentShowModel;
  List<Widget>? seasonList;

  @override
  void initState() {
    super.initState();
    getCastModels();
  }

  getCastModels() async {
    return getCastObj.getCast(widget.id, "show");
  }

  getCurrentShowModel() async {
    ShowModel tempModel = await getShowsObj.getShowDetails(widget.id);
    print(tempModel.seasons.length);
    seasonList = List.generate(
      tempModel.seasons.length,
      (index) => InkWell(
        onTap: () {
          print(tempModel.seasons[index].name.toString());
        },
        child: ListTile(
          title: Text(
            tempModel.seasons[index].name.toString(),
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
      growable: true,
    );
    return tempModel;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: getCurrentShowModel(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data.posterPath}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black87]),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 90,
                      ),
                      Center(
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 50,
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data.posterPath}',
                            height: 400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Center(
                          child: Text(
                            snapshot.data.name ?? "Movie Name",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      ExpansionTile(
                        title: const Text("Synopsis"),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, bottom: 10, right: 10),
                            child:
                                Text(snapshot.data.overview ?? "{{overview}}"),
                          )
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: seasonList!,
                              );
                            },
                          );
                        },
                        child: const Text("Select Season"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FutureBuilder(
                          future: getCastModels(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            Widget children;
                            if (snapshot.hasData) {
                              children = SizedBox(
                                height: 180,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {},
                                      child: SizedBox(
                                        width: 100,
                                        child: Card(
                                          elevation: 0,
                                          color: Colors.transparent,
                                          semanticContainer: true,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Column(
                                            children: [
                                              Image.network(
                                                'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data[index].profilePath}',
                                                fit: BoxFit.cover,
                                                height: 136,
                                              ),
                                              Text(
                                                snapshot.data[index].name
                                                    .split(" ")[0],
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                snapshot.data[index].name
                                                            .split(" ")
                                                            .length ==
                                                        1
                                                    ? ""
                                                    : snapshot.data[index].name
                                                        .split(" ")[1],
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              children = const CircularProgressIndicator();
                            }
                            return children;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 37),
                  child: BackButton(),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
