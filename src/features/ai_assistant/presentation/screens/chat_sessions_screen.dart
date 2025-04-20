import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../application/providers/ai_assistant_providers.dart';
import '../../../../domain/models/chat_session.dart';

class ChatSessionsScreen extends ConsumerWidget {
  const ChatSessionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(aiAssistantServiceProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Сессии чата')),
      body: FutureBuilder<List<ChatSession>>(
        future: service.getSessions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }
          final sessions = snapshot.data ?? [];
          if (sessions.isEmpty) {
            return const Center(child: Text('Нет сессий. Создайте новую!'));
          }
          return ListView.separated(
            itemCount: sessions.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final session = sessions[index];
              return ListTile(
                title: Text(
                  session.title.isNotEmpty ? session.title : 'Без названия',
                ),
                subtitle: Text('Создана: ${_formatDate(session.createdAt)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder:
                          (ctx) => AlertDialog(
                            title: const Text('Удалить сессию?'),
                            content: const Text(
                              'Вы уверены, что хотите удалить эту сессию?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, false),
                                child: const Text('Отмена'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                child: const Text('Удалить'),
                              ),
                            ],
                          ),
                    );
                    if (confirm == true) {
                      await service.deleteSession(session.id);
                      (context as Element).reassemble(); // обновить список
                    }
                  },
                ),
                onTap: () {
                  ref.read(currentChatSessionProvider.notifier).state =
                      session.id;
                  Navigator.pop(context);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = await _showCreateDialog(context);
          if (title != null) {
            await service.createSession(title: title);
            (context as Element).reassemble();
          }
        },
        child: const Icon(Icons.add),
        tooltip: 'Создать новую сессию',
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year}';
  }

  Future<String?> _showCreateDialog(BuildContext context) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Новая сессия'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Название сессии'),
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, controller.text.trim()),
                child: const Text('Создать'),
              ),
            ],
          ),
    );
  }
}
