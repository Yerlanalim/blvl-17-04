import 'package:flutter/material.dart';
import 'package:blvl_17_04_tmp/src/domain/models/business_info.dart';

class BusinessInfoCard extends StatelessWidget {
  final BusinessInfo? businessInfo;
  const BusinessInfoCard({Key? key, this.businessInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (businessInfo == null) {
      return SizedBox.shrink();
    }
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Бизнес-информация',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Text('Название бизнеса: ${businessInfo!.companyName}'),
            Text('Сфера деятельности: ${businessInfo!.industry}'),
            if (businessInfo!.companySize != null)
              Text('Размер компании: ${businessInfo!.companySize}'),
            if (businessInfo!.location != null &&
                businessInfo!.location!.isNotEmpty)
              Text('Локация: ${businessInfo!.location}'),
            if (businessInfo!.description != null &&
                businessInfo!.description!.isNotEmpty)
              Text('Описание: ${businessInfo!.description}'),
          ],
        ),
      ),
    );
  }
}
