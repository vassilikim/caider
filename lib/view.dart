import 'package:caider/auth/login.dart';
import 'package:flutter/material.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 203, 222, 199),
      body: Center(
        child: CircleAvatar(
          radius: 60,
          backgroundImage: FileImage(user['profileImage']),
        ),
      ),
    );
  }
}
