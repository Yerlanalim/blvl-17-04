import 'package:flutter/material.dart';

class ProfileActionButtons extends StatelessWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onShare;
  const ProfileActionButtons({Key? key, this.onEdit, this.onShare})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: onEdit,
          icon: Icon(Icons.edit),
          label: Text('Редактировать'),
        ),
        SizedBox(width: 16),
        OutlinedButton.icon(
          onPressed: onShare,
          icon: Icon(Icons.share),
          label: Text('Поделиться'),
        ),
      ],
    );
  }
}
