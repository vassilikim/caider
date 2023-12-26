import 'dart:io';

import 'package:caider/auth/login.dart';
import 'package:caider/database/data.dart';
import 'package:caider/database/users.dart';
import 'package:caider/widgets/auth_widgets.dart';
import 'package:caider/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

bool justSignedUp = false;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String firstName = '';
  late String lastName = '';
  late String email = '';
  late String phoneNumber = '';
  late String password = '';
  late String confirmPassword = '';

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool passwordVisible = false;
  bool confirmPasswordVisible = false;

  final ImagePicker picker = ImagePicker();

  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void signUp() async {
    if (firstName == '' ||
        lastName == '' ||
        email == '' ||
        phoneNumber == '' ||
        password == '' ||
        confirmPassword == '') {
      return MyMessageHandler.showSnackbar(
          context,
          _scaffoldKey,
          'Please fill all the fields.',
          const Color.fromARGB(255, 238, 150, 150));
    } else if (!email.isValidEmail()) {
      return MyMessageHandler.showSnackbar(context, _scaffoldKey,
          'Invalid email address.', const Color.fromARGB(255, 238, 150, 150));
    } else if (!phoneNumber.isValidPhoneNumber()) {
      return MyMessageHandler.showSnackbar(context, _scaffoldKey,
          'Invalid phone number.', const Color.fromARGB(255, 238, 150, 150));
    } else if (!(password == confirmPassword)) {
      return MyMessageHandler.showSnackbar(
          context,
          _scaffoldKey,
          'The two passwords do not match.',
          const Color.fromARGB(255, 238, 150, 150));
    } else {
      User currentUser = users.firstWhere(
        (user) => user.toJson()["email"] == email,
        orElse: () =>
            User("null", "null", "null", "null", "null", [], File("null")),
      );
      if (currentUser.toJson()["email"] != "null") {
        return MyMessageHandler.showSnackbar(
            context,
            _scaffoldKey,
            'This email address is already in use.',
            const Color.fromARGB(255, 238, 150, 150));
      }

      User newUser = User(
        firstName,
        lastName,
        email,
        phoneNumber,
        password,
        [],
        _image == null ? File("null") : _image!,
      );
      users.add(newUser);

      setState(() {
        justSignedUp = true;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const LoginPage();
      }));
    }
  }

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
          return const LoginPage();
        }));
      },
      child: ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 203, 222, 199),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60, bottom: 30),
                    child: MaterialButton(
                      onPressed: () {
                        _pickImage(ImageSource.gallery);
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: _image == null
                                ? const AssetImage('./assets/profile.png')
                                : FileImage(_image!) as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          height: 49,
                          width: 252,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 234, 253, 238),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, top: 6),
                            child: TextFormField(
                              onChanged: (value) {
                                firstName = value;
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'First Name',
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
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          height: 49,
                          width: 252,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 234, 253, 238),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, top: 6),
                            child: TextFormField(
                              onChanged: (value) {
                                lastName = value;
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Last Name',
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
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          height: 49,
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
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          height: 49,
                          width: 252,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 234, 253, 238),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, top: 6),
                            child: TextFormField(
                              onChanged: (value) {
                                phoneNumber = value;
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Phone Number',
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
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          height: 49,
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
                                  padding: const EdgeInsets.only(
                                      right: 8, bottom: 8),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          height: 49,
                          width: 252,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 234, 253, 238),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, top: 6),
                            child: TextFormField(
                              onChanged: (value) {
                                confirmPassword = value;
                              },
                              obscureText: !confirmPasswordVisible,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirm password',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, bottom: 8),
                                  child: IconButton(
                                    icon: Icon(
                                      confirmPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        confirmPasswordVisible =
                                            !confirmPasswordVisible;
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      height: 46,
                      width: 141,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 131, 159, 128),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextButton(
                        onPressed: () {
                          signUp();
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color.fromARGB(255, 255, 255, 255),
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
      ),
    );
  }
}
