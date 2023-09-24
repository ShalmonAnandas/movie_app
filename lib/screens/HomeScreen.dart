import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/widgets/SearchResults.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 20, bottom: 10),
          child: TextField(
            controller: searchController,
            style: GoogleFonts.quicksand(fontWeight: FontWeight.w900),
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              hintText: "Search",
              hintStyle: GoogleFonts.quicksand(fontWeight: FontWeight.w900),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        (searchController.text.isNotEmpty)
            ? SearchResultScreen(searchTerm: searchController.text)
            : Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 10, bottom: 20),
                child: Text(
                  "Welcome back!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.width * 0.1),
                ),
              ),
      ],
    );
  }
}
