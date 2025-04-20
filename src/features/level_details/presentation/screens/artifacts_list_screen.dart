import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/artifact_list_item.dart';
import '../providers/artifacts_ui_providers.dart';
import '../../../../../lib/src/domain/models/artifact.dart';
import '../../../../../lib/src/application/providers/artifact_providers.dart';

class ArtifactsListScreen extends ConsumerWidget {
  final String levelId;
  const ArtifactsListScreen({Key? key, required this.levelId})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(artifactFilterProvider);
    final sort = ref.watch(artifactSortProvider);
    final artifactsAsync = ref.watch(artifactsListProvider(levelId));

    return Scaffold(
      appBar: AppBar(title: const Text('Артефакты')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Поиск артефактов...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged:
                        (value) =>
                            ref.read(artifactFilterProvider.notifier).state =
                                value,
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: sort,
                  items: const [
                    DropdownMenuItem(
                      value: 'title',
                      child: Text('По названию'),
                    ),
                    DropdownMenuItem(value: 'type', child: Text('По типу')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(artifactSortProvider.notifier).state = value;
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: artifactsAsync.when(
              data: (artifacts) {
                // Фильтрация и сортировка
                var filtered =
                    artifacts
                        .where(
                          (a) => a.title.toLowerCase().contains(
                            filter.toLowerCase(),
                          ),
                        )
                        .toList();
                if (sort == 'title') {
                  filtered.sort((a, b) => a.title.compareTo(b.title));
                } else if (sort == 'type') {
                  filtered.sort((a, b) => a.fileType.compareTo(b.fileType));
                }
                if (filtered.isEmpty) {
                  return const Center(child: Text('Нет артефактов'));
                }
                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final artifact = filtered[index];
                    return ArtifactListItem(artifact: artifact);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Ошибка: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
