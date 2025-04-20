import 'package:flutter/material.dart';

class VideoLoadingIndicator extends StatelessWidget {
  const VideoLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
