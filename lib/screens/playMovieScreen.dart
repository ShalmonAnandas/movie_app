import 'package:flutter/material.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';

class VideoPlayer extends StatefulWidget {
  final String url;
  final String name;
  const VideoPlayer({super.key, required this.url, required this.name});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: YoYoPlayer(
          displayFullScreenAfterInit: true,
          url: widget.url,
          videoStyle: const VideoStyle(
            playIcon: Icon(Icons.play_arrow),
            pauseIcon: Icon(Icons.pause),
            fullscreenIcon: Icon(Icons.fullscreen),
            forwardIcon: Icon(Icons.skip_next),
            backwardIcon: Icon(Icons.skip_previous),
          ),
          videoLoadingStyle: const VideoLoadingStyle(
            loading: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
