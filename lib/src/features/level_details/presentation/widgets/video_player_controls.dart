import 'package:flutter/material.dart';

class VideoPlayerControls extends StatelessWidget {
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final VoidCallback onRewind;
  final VoidCallback onForward;
  final bool isPlaying;

  const VideoPlayerControls({
    Key? key,
    required this.onPlay,
    required this.onPause,
    required this.onRewind,
    required this.onForward,
    required this.isPlaying,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon: Icon(Icons.replay_10), onPressed: onRewind),
        isPlaying
            ? IconButton(icon: Icon(Icons.pause), onPressed: onPause)
            : IconButton(icon: Icon(Icons.play_arrow), onPressed: onPlay),
        IconButton(icon: Icon(Icons.forward_10), onPressed: onForward),
      ],
    );
  }
}
