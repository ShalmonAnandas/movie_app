import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FutureBuilder(
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
                              'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data[index].profilePath}',
                              fit: BoxFit.cover,
                              height: 130,
                            ),
                            Text(
                              snapshot.data[index].name.split(" ")[0],
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              snapshot.data[index].name.split(" ").length == 1
                                  ? ""
                                  : snapshot.data[index].name.split(" ")[1],
                              style: const TextStyle(color: Colors.white),
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
    );
  }
}
