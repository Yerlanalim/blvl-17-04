import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String? photoUrl;
  final String? email;
  const ProfileHeader({Key? key, required this.name, this.photoUrl, this.email})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage:
                photoUrl != null && photoUrl!.isNotEmpty
                    ? NetworkImage(photoUrl!)
                    : null,
            child:
                photoUrl == null || photoUrl!.isEmpty
                    ? Icon(Icons.person, size: 40)
                    : null,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: Theme.of(context).textTheme.titleLarge),
              if (email != null && email!.isNotEmpty)
                Text(email!, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
