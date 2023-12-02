import 'package:flutter/material.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  const VideoPlayerScreen({super.key, required this.url});
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      widget.url, //to access its parent class constructor or variable
    );

    _controller.addListener(() {
      setState(() {});
    }); //loop through video
    _controller.initialize(); //initialize the VideoPlayer
  }

  @override
  void dispose() {
    _controller.dispose(); //dispose the VideoPlayer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3.2 / 4,
              child: Stack(
                children: [
                  VideoPlayer(_controller),
                  _PlayPauseOverlay(
                    controller: _controller,
                  ),
                ],
              ),
            ),
            Container(
              height: 40.0,
              color: Colors.black,
              child: Row(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 50),
                    reverseDuration: const Duration(milliseconds: 200),
                    child: IconButton(
                      icon: Icon(
                        _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            _controller.play();
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: VideoProgressIndicator(
                        _controller,
                        padding: EdgeInsets.zero,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                          backgroundColor: AppColors.white,
                          playedColor: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // AutoOrientation.landscapeAutoMode();
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return FullScreenDialog(
                            controller: _controller,
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.fullscreen,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key? key, required this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.play();
          },
        ),
      ],
    );
  }
}

class FullScreenDialog extends StatefulWidget {
  final VideoPlayerController controller;
  const FullScreenDialog({super.key, required this.controller});

  @override
  State<FullScreenDialog> createState() => _FullScreenDialogState();
}

class _FullScreenDialogState extends State<FullScreenDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      // backgroundColor: Colors.transparent,
      child: InkWell(
        onTap: () {
          // AutoOrientation.portraitAutoMode();
          Navigator.of(context).pop();
        },
        child: Container(
          alignment: Alignment.topCenter,
          child: Stack(
            fit: StackFit.expand,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: widget.controller.value.size.width,
                  height: widget.controller.value.size.height,
                  child: AspectRatio(
                    aspectRatio: widget.controller.value.aspectRatio,
                    child: VideoPlayer(
                      widget.controller,
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40.0,
                      color: Colors.black,
                      child: Row(
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 50),
                            reverseDuration: const Duration(milliseconds: 200),
                            child: IconButton(
                              icon: Icon(
                                widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                color: AppColors.primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (widget.controller.value.isPlaying) {
                                    widget.controller.pause();
                                  } else {
                                    widget.controller.play();
                                  }
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: VideoProgressIndicator(
                                widget.controller,
                                padding: EdgeInsets.zero,
                                allowScrubbing: true,
                                colors: const VideoProgressColors(
                                  backgroundColor: AppColors.white,
                                  playedColor: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // AutoOrientation.portraitAutoMode();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.fullscreen_exit,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerFullscreenWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerFullscreenWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => controller.value.isInitialized
      ? Container(alignment: Alignment.topCenter, child: buildVideo())
      : const Center(child: CircularProgressIndicator());

  Widget buildVideo() => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          buildVideoPlayer(),
        ],
      );

  Widget buildVideoPlayer() => buildFullScreen(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );

  Widget buildFullScreen({
    required Widget child,
  }) {
    final size = controller.value.size;
    final width = size.width;
    final height = size.height;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}

class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const BasicOverlayWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          controller.value.isPlaying ? controller.pause() : controller.play();
        },
        child: Stack(
          children: <Widget>[
            buildPlay(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: buildIndicator(),
            ),
          ],
        ),
      );

  Widget buildIndicator() => VideoProgressIndicator(
        controller,
        allowScrubbing: true,
      );

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: const Icon(Icons.play_arrow, color: Colors.white, size: 80),
        );
}
