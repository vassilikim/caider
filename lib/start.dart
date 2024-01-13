import 'dart:async';

import 'package:caider/auth/login.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.easeOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var fadeAnimation = animation.drive(tween);

            return FadeTransition(opacity: fadeAnimation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 203, 222, 199),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'cAIDer',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Color.fromARGB(255, 35, 56, 29),
                      fontSize: 57,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Image.asset(
                  'assets/logo.png',
                  width: 327,
                  height: 327,
                ),
                const Column(
                  children: [
                    Text(
                      'Connecting the Gaps',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color.fromARGB(255, 35, 56, 29),
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'Aiding the World',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color.fromARGB(255, 35, 56, 29),
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
              ],
            ),
          ),
        ));
  }
}
