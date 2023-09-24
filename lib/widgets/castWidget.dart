import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/getCast.dart';

class CastWidget extends StatelessWidget {
  final int id;
  final String mediaType;
  final GetCast getCastObj = GetCast();

  CastWidget({
    super.key,
    required this.id,
    required this.mediaType,
  });

  getCastModels() async {
    return getCastObj.getCast(id, mediaType);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Cast",
          style: GoogleFonts.quicksand(fontWeight: FontWeight.w900),
        ),
        children: [
          FutureBuilder(
            future: getCastModels(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              Widget children;
              if (snapshot.hasData) {
                children = SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: SizedBox(
                          width: 100,
                          child: Card(
                            elevation: 0,
                            color: Colors.transparent,
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Column(
                              children: [
                                Image.network(
                                  (snapshot.data[index].profilePath != null)
                                      ? 'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data[index].profilePath}'
                                      : "https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg",
                                  fit: BoxFit.cover,
                                  height: 130,
                                ),
                                Text(
                                  snapshot.data[index].name.split(" ")[0],
                                  style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  snapshot.data[index].name.split(" ").length ==
                                          1
                                      ? ""
                                      : snapshot.data[index].name.split(" ")[1],
                                  style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w700),
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
                children = SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return children;
            },
          ),
        ]);
  }
}
