import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 203, 222, 199),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
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
                const SizedBox(
                  height: 20,
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
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
