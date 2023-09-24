import 'package:flutter/material.dart';
import 'package:movie_app/widgets/backButton.dart';
import 'package:adblocker_webview/adblocker_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoviePlayer extends StatefulWidget {
  final int id;
  final String name;
  const MoviePlayer({super.key, required this.id, required this.name});

  @override
  State<MoviePlayer> createState() => _MoviePlayerState();
}

class _MoviePlayerState extends State<MoviePlayer> {
  final WebViewController controller = WebViewController();

  @override
  void initState() {
    super.initState();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://vidsrc.to/embed/movie/${widget.id}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Watching ${widget.name}"),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
