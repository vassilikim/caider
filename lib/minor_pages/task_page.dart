import 'package:caider/database/tasks.dart';
import 'package:caider/home.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  final Task currentTask;
  const TaskPage({super.key, required this.currentTask});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const HomePage(
            initialIndex: 0,
          );
        }));
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 203, 222, 199),
        body: Center(
          child: Text(
            widget.currentTask.toJson()['name'],
          ),
        ),
      ),
    );
  }
}
