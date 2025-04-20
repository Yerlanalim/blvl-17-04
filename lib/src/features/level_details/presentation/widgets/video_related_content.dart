import 'package:flutter/material.dart';

class VideoRelatedContent extends StatelessWidget {
  final List<String> tests;
  final List<String> artifacts;
  final VoidCallback? onTestTap;
  final VoidCallback? onArtifactTap;

  const VideoRelatedContent({
    Key? key,
    required this.tests,
    required this.artifacts,
    this.onTestTap,
    this.onArtifactTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (tests.isNotEmpty) ...[
          Text('Связанные тесты:'),
          ...tests.map((t) => ListTile(title: Text(t), onTap: onTestTap)),
        ],
        if (artifacts.isNotEmpty) ...[
          Text('Артефакты:'),
          ...artifacts.map(
            (a) => ListTile(title: Text(a), onTap: onArtifactTap),
          ),
        ],
      ],
    );
  }
}
