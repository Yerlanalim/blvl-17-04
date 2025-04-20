import 'package:flutter/material.dart';

class FilePreviewWidget extends StatelessWidget {
  final String filePath;
  final String fileType;
  const FilePreviewWidget({
    Key? key,
    required this.filePath,
    required this.fileType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Реализовать предпросмотр файла по типу
    return Center(child: Text('Preview: $fileType'));
  }
}
