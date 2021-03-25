import 'dart:async';

import 'dart:io';

import 'package:MTR_flutter/screens/tabs/home/admin/customize_screens/customize_header/customize_header_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final bool autoPlay;
  final bool loop;
  final bool mixWithOthers;
  final String videoSource;

  VideoPlayerScreen(
      {Key key,
      this.autoPlay = false,
      this.loop = false,
      this.mixWithOthers = true,
      this.videoSource = "assets/videos/background_video_4.mp4"})
      : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    // _controller = VideoPlayerController.network(
    //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    // );

    // var file = new File("assets/videos/background_video.mp4");

    // _controller = VideoPlayerController.file(file);
    _controller = VideoPlayerController.asset(widget.videoSource,
        videoPlayerOptions:
            VideoPlayerOptions(mixWithOthers: widget.mixWithOthers));

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setVolume(0.0);
    _controller.setLooping(widget.loop);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        // Use a FutureBuilder to display a loading spinner while waiting for the
        // VideoPlayerController to finish initializing.
        FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          if (widget.autoPlay) {
            _controller.play();
          }

          print(
              "########################aspec ratio: ${_controller.value.aspectRatio}");

          BoxFit boxfit = (_controller.value.size?.width ?? 0) <
                  MediaQuery.of(context).size.width
              ? BoxFit.cover
              : BoxFit.fitHeight;

          return FittedBox(
            fit: boxfit,
            child: SizedBox(
              width: _controller.value.size?.width ?? 0,
              height: _controller.value.size?.height ?? 0,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(_controller),
              ),
            ),
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          // return Center(child: CircularProgressIndicator());
          return Center(child: Container());
        }
      },
    );
    // floatingActionButton: FloatingActionButton(
    //   onPressed: () {
    //     // Wrap the play or pause in a call to `setState`. This ensures the
    //     // correct icon is shown.
    //     setState(() {
    //       // If the video is playing, pause it.
    //       if (_controller.value.isPlaying) {
    //         _controller.pause();
    //       } else {
    //         // If the video is paused, play it.
    //         _controller.play();
    //       }
    //     });
    //   },
    //   // Display the correct icon depending on the state of the player.
    //   child: Icon(
    //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //   ),
    // ), // This trailing comma makes auto-formatting nicer for build methods.
  }
}
