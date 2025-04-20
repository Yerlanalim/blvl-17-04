import 'package:flutter/material.dart';

class VideoVolumeControl extends StatelessWidget {
  final double volume; // 0.0 - 1.0
  final ValueChanged<double> onVolumeChanged;

  const VideoVolumeControl({
    Key? key,
    required this.volume,
    required this.onVolumeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.volume_up),
        Expanded(
          child: Slider(
            value: volume,
            min: 0.0,
            max: 1.0,
            onChanged: onVolumeChanged,
          ),
        ),
      ],
    );
  }
}
