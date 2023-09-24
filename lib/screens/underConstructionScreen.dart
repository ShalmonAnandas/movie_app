import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class UnderConstructionScreen extends StatelessWidget {
  const UnderConstructionScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Text(
                title,
                style: GoogleFonts.quicksand(
                    fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Lottie.asset("assets/underConstruction.json",
                frameRate: FrameRate(120))),
      ],
    );
  }
}
