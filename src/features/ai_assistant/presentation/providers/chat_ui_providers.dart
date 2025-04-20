import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/chat_screen_controller.dart';

final chatScreenControllerProvider =
    StateNotifierProvider<ChatScreenController, void>((ref) {
      // TODO: реализовать провайдер для ChatScreenController
      return ChatScreenController();
    });
