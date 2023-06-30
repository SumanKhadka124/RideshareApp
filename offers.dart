import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';

class Offers extends StatefulWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> implements YouTubePlayerListener {
  late FlutterYoutubeViewController _controller;

  @override
  void onReady() {
    // Called when the player is ready
    _controller.play();
  }

  @override
  void onStateChange(String state) {
    // Called when the player state changes (e.g., 'playing', 'paused', 'ended')
  }

  @override
  void onError(String error) {
    // Called when an error occurs in the player
  }

  @override
  void onCurrentSecond(double second) {
    // Called when the current playback time changes
  }

  @override
  void onVideoDuration(double duration) {
    // Called when the video duration is obtained
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offers in BHATBHATE'),
      ),
      backgroundColor: const Color.fromARGB(255, 210, 233, 196),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: FlutterYoutubeView(
          onViewCreated: _onYoutubeCreated,
          listener: this,
          params: const YoutubeParam(
            videoId: 'XhLRQkcmB44',
            showUI: true,
            startSeconds: 0.0,
            autoPlay: false,
          ),
        ),
      ),
    );
  }

  void _onYoutubeCreated(FlutterYoutubeViewController controller) {
    _controller = controller;
  }
}
