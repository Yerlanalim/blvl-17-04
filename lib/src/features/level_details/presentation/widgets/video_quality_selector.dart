import 'package:flutter/material.dart';

class VideoQualitySelector extends StatelessWidget {
  final List<String> qualities;
  final String selectedQuality;
  final ValueChanged<String> onQualitySelected;

  const VideoQualitySelector({
    Key? key,
    required this.qualities,
    required this.selectedQuality,
    required this.onQualitySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedQuality,
      items:
          qualities
              .map((q) => DropdownMenuItem(value: q, child: Text(q)))
              .toList(),
      onChanged: (value) {
        if (value != null) onQualitySelected(value);
      },
    );
  }
}
