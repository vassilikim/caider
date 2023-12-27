import 'dart:io';

import 'package:caider/auth/signup.dart';
import 'package:caider/database/data.dart';
import 'package:caider/database/users.dart';
import 'package:caider/home.dart';
import 'package:caider/widgets/auth_widgets.dart';
import 'package:caider/widgets/snackbar.dart';
import 'package:flutter/material.dart';

Map<String, dynamic> user = {};

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email = '';
  late String password = '';

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool passwordVisible = false;

  void logIn() async {
    if (email == '' || password == '') {
      return MyMessageHandler.showSnackbar(
          context,
          _scaffoldKey,
          'Please fill all the fields.',
          const Color.fromARGB(255, 238, 150, 150));
    } else if (!email.isValidEmail()) {
      return MyMessageHandler.showSnackbar(context, _scaffoldKey,
          'Invalid email address.', const Color.fromARGB(255, 238, 150, 150));
    } else {
      User currentUser = users.firstWhere(
        (user) =>
            user.toJson()['email'] == email &&
            user.toJson()['password'] == password,
        orElse: () => User(
            "null", "null", "null", "null", "null", [], File('null'), 0, 0),
      );
      if (currentUser.toJson()["email"] == "null") {
        return MyMessageHandler.showSnackbar(
            context,
            _scaffoldKey,
            'Wrong email or password.',
            const Color.fromARGB(255, 238, 150, 150));
      }
      user = currentUser.toJson();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const HomePage(
          initialIndex: 0,
        );
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      if (justSignedUp) {
        MyMessageHandler.showSnackbar(
            context,
            _scaffoldKey,
            'Login with your new account.',
            const Color.fromARGB(255, 168, 190, 163));
      }
      setState(() {
        justSignedUp = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 203, 222, 199),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Image.asset(
                        'assets/login_lock.png',
                        width: 280,
                        height: 327,
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            height: 65,
                            width: 252,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 234, 253, 238),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30, top: 6),
                              child: TextFormField(
                                onChanged: (value) {
                                  email = value;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            height: 65,
                            width: 252,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 234, 253, 238),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30, top: 6),
                              child: TextFormField(
                                onChanged: (value) {
                                  password = value;
                                },
                                obscureText: !passwordVisible,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: const TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: IconButton(
                                      icon: Icon(
                                        passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          passwordVisible = !passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 55,
                ),
                Container(
                  height: 46,
                  width: 141,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 131, 159, 128),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: TextButton(
                    onPressed: () {
                      logIn();
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                  width: 181,
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const SignUpPage();
                        }));
                      },
                      child: const Text(
                        'Create new account ?',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color.fromARGB(255, 131, 159, 128),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
