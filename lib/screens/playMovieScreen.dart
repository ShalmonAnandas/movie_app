import 'package:flutter/material.dart';
import 'package:movie_app/widgets/backButton.dart';
import 'package:adblocker_webview/adblocker_webview.dart';

class MoviePlayer extends StatefulWidget {
  final int id;
  const MoviePlayer({super.key, required this.id});

  @override
  State<MoviePlayer> createState() => _MoviePlayerState();
}

class _MoviePlayerState extends State<MoviePlayer> {
  final _adBlockerWebviewController = AdBlockerWebviewController.instance;

  @override
  void initState() {
    super.initState();
    _adBlockerWebviewController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // appBar: AppBar(
      //   title: const Text("Movie Title"),
      // ),
      child: Stack(
        children: [
          AdBlockerWebview(
            url: Uri.parse("https://vidsrc.me/embed/${widget.id}/color-2986cc"),
            adBlockerWebviewController: _adBlockerWebviewController,
            shouldBlockAds: true,
          ),
          const CustomBackButton(),
        ],
      ),
    );
  }
}
