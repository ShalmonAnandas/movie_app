import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/models/showModel.dart';
import 'package:movie_app/screens/playMovieScreen.dart';
import 'package:movie_app/utils/getIndividual.dart';
import 'package:movie_app/utils/getCast.dart';
import 'package:movie_app/widgets/castWidget.dart';
import 'package:movie_app/widgets/similarMediaWidget.dart';

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
  GetIndividual getTvObj = GetIndividual();
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

  getCurrentTvModel() async {
    ShowModel tempModel = await getTvObj.getIndividualDetails(widget.id, "tv");
    print(tempModel.seasons.length);
    seasonList = List.generate(
      tempModel.seasons.length,
      (index) => Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: ListTile(
              title: Text(
                tempModel.seasons[index].name.toString(),
                style: GoogleFonts.quicksand(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Divider()
        ],
      ),
      growable: true,
    );
    return tempModel;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.isFirst);
        return true;
      },
      child: FutureBuilder<dynamic>(
        future: getCurrentTvModel(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
              ),
              floatingActionButton: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white10, Colors.white60, Colors.white],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10, top: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          showDragHandle: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) {
                            return DraggableScrollableSheet(
                              expand: true,
                              minChildSize: 1,
                              maxChildSize: 1,
                              initialChildSize: 1,
                              builder: (BuildContext context, ScrollController scrollController) {
                                return BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                                  child: ListView.builder(
                                    itemCount: seasonList!.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return seasonList![index];
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Text(
                        "Select Season",
                        style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.white60, Colors.white],
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
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
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.quicksand(fontSize: 25, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              ExpansionTile(
                                title: Text(
                                  "Synopsis",
                                  style: GoogleFonts.quicksand(fontWeight: FontWeight.w900),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0, bottom: 10, right: 10),
                                    child: Text(snapshot.data.overview ?? "{{overview}}"),
                                  )
                                ],
                              ),
                              SimilarMoviesWidget(
                                id: widget.id,
                                mediaType: "show",
                              ),
                              CastWidget(
                                id: widget.id,
                                mediaType: "show",
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
