import 'package:flutter/material.dart';

class SelectEpisodeScreen extends StatefulWidget {
  const SelectEpisodeScreen({super.key, required this.id, required this.seasonNumber});

  final int id;
  final int seasonNumber;
  @override
  State<SelectEpisodeScreen> createState() => _SelectEpisodeScreenState();
}

class _SelectEpisodeScreenState extends State<SelectEpisodeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
