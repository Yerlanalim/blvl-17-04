import 'package:flutter/material.dart';

class ArtifactTypeIcon extends StatelessWidget {
  final String fileType;
  const ArtifactTypeIcon({Key? key, required this.fileType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Реализовать иконку типа файла
    return Icon(Icons.insert_drive_file);
  }
}
