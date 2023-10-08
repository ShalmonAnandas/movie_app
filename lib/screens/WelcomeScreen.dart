import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/screens/underConstructionScreen.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome Back",
          style:
              GoogleFonts.quicksand(fontSize: 30, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10, bottom: 10),
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
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: SearchResultScreen(searchTerm: searchController.text),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
