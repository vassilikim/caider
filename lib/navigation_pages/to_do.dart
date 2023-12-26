import 'package:flutter/material.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 203, 222, 199),
      body: Center(
        child: Text('To do'),
      ),
    );
  }
}
