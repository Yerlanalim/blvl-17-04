import 'package:flutter/material.dart';
import '../widgets/file_preview_widget.dart';

class ArtifactViewerScreen extends StatelessWidget {
  final String filePath;
  final String fileType;
  const ArtifactViewerScreen({
    Key? key,
    required this.filePath,
    required this.fileType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Просмотр артефакта')),
      body: FilePreviewWidget(filePath: filePath, fileType: fileType),
    );
  }
}
