import 'dart:io';

import 'package:caider/auth/login.dart';
import 'package:caider/database/data.dart';
import 'package:caider/database/users.dart';
import 'package:caider/home.dart';
import 'package:caider/widgets/auth_widgets.dart';
import 'package:caider/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController firstNameController =
      TextEditingController(text: user['firstName']);
  TextEditingController lastNameController =
      TextEditingController(text: user['lastName']);
  TextEditingController emailController =
      TextEditingController(text: user['email']);
  TextEditingController phoneNumberController =
      TextEditingController(text: user['phoneNumber']);

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  final ImagePicker picker = ImagePicker();

  File? _image = user['profileImage'];

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void saveProfile() async {
    if (firstNameController.text == '' ||
        lastNameController.text == '' ||
        emailController.text == '' ||
        phoneNumberController.text == '') {
      return MyMessageHandler.showSnackbar(
          context,
          _scaffoldKey,
          'All fields must be filled.',
          const Color.fromARGB(255, 238, 150, 150));
    } else if (!emailController.text.isValidEmail()) {
      return MyMessageHandler.showSnackbar(context, _scaffoldKey,
          'Invalid email address.', const Color.fromARGB(255, 238, 150, 150));
    } else if (!phoneNumberController.text.isValidPhoneNumber()) {
      return MyMessageHandler.showSnackbar(context, _scaffoldKey,
          'Invalid phone number.', const Color.fromARGB(255, 238, 150, 150));
    } else {
      User currentUser = users.firstWhere(
        (user) => user.toJson()["email"] == emailController.text,
        orElse: () => User(
            "null", "null", "null", "null", "null", [], File("null"), 0, 0),
      );
      if (currentUser.toJson()["email"] != "null" &&
          user['email'] != emailController.text) {
        return MyMessageHandler.showSnackbar(
            context,
            _scaffoldKey,
            'This email address is already in use.',
            const Color.fromARGB(255, 238, 150, 150));
      }

      users.removeWhere((user1) => user1.toJson()["email"] == user['email']);

      User updatedUser = User(
          firstNameController.text,
          lastNameController.text,
          emailController.text,
          phoneNumberController.text,
          user['password'],
          user['tasks'],
          _image!,
          user['level'],
          user['points']);
      users.add(updatedUser);

      user = updatedUser.toJson();

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const HomePage(
          initialIndex: 3,
        );
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
          return const HomePage(
            initialIndex: 3,
          );
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
                      padding:
                          const EdgeInsets.only(top: 60, right: 30, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return const HomePage(
                                  initialIndex: 3,
                                );
                              }));
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _image = File("null");
                              });
                            },
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor:
                                  const Color.fromARGB(255, 203, 222, 199),
                              backgroundImage: _image!.path == "null"
                                  ? const AssetImage('./assets/profile.png')
                                  : FileImage(_image!) as ImageProvider,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                _pickImage(ImageSource.gallery);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
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
                                controller: firstNameController,
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
                                controller: lastNameController,
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
                                controller: emailController,
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
                                controller: phoneNumberController,
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
                            saveProfile();
                          },
                          child: const Text(
                            'Save',
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
            )),
      ),
    );
  }
}
