import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String message;
  const ErrorMessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Реализовать виджет отображения ошибки
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(message, style: const TextStyle(color: Colors.red)),
    );
  }
}
