import 'package:flutter/material.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 203, 222, 199),
      body: Center(
        child: Text('Completed'),
      ),
    );
  }
}
