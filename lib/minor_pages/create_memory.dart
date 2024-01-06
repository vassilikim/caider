import 'dart:io';

import 'package:caider/auth/login.dart';
import 'package:caider/database/data.dart';
import 'package:caider/database/tasks.dart';
import 'package:caider/database/users.dart';
import 'package:caider/home.dart';
import 'package:caider/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

bool justCompletedTask = false;
int pointsGained = 0;

class CreateMemoryPage extends StatefulWidget {
  final Task currentTask;
  const CreateMemoryPage({super.key, required this.currentTask});

  @override
  State<CreateMemoryPage> createState() => _CreateMemoryPageState();
}

class _CreateMemoryPageState extends State<CreateMemoryPage> {
  late String textMemory = '';

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

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

  void completeTask() async {
    if (textMemory == '') {
      return MyMessageHandler.showSnackbar(
          context,
          _scaffoldKey,
          'Please fill in your memory.',
          const Color.fromARGB(255, 238, 150, 150));
    } else if (_image == null) {
      return MyMessageHandler.showSnackbar(
          context,
          _scaffoldKey,
          'Please choose a photo to upload.',
          const Color.fromARGB(255, 238, 150, 150));
    } else {}

    User currentUser = users.firstWhere(
      (user1) => user1.toJson()["email"] == user['email'],
      orElse: () =>
          User("null", "null", "null", "null", "null", [], File("null"), 0, 0),
    );
    if (currentUser.toJson()["email"] == "null") {
      return MyMessageHandler.showSnackbar(
        context,
        _scaffoldKey,
        'Something went wrong!.',
        const Color.fromARGB(255, 238, 150, 150),
      );
    }

    users.removeWhere((user1) => user1.toJson()["email"] == user['email']);

    List<dynamic> updatedTasks = currentUser
        .toJson()['tasks']
        .where((task) =>
            task['task'].toJson()['name'] !=
            widget.currentTask.toJson()['name'])
        .toList();

    updatedTasks.add({
      "task": widget.currentTask,
      "status": "completed",
      "memory": {"text": textMemory, "image": _image}
    });

    int finalLevel = currentUser.toJson()['level'];
    int finalPoints =
        currentUser.toJson()['points'] + widget.currentTask.toJson()['reward'];

    if (finalPoints >= 100) {
      finalLevel = finalLevel + 1;
      finalPoints = finalPoints - 100;
    }

    User updatedUser = User(
        currentUser.toJson()['firstName'],
        currentUser.toJson()['lastName'],
        currentUser.toJson()['email'],
        currentUser.toJson()['phoneNumber'],
        currentUser.toJson()['password'],
        updatedTasks,
        currentUser.toJson()['profileImage'],
        finalLevel,
        finalPoints);
    users.add(updatedUser);

    user = updatedUser.toJson();

    setState(() {
      justCompletedTask = true;
      pointsGained = widget.currentTask.toJson()['reward'];
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const HomePage(
        initialIndex: 1,
      );
    }));
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
            initialIndex: 1,
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
                        const EdgeInsets.only(top: 40, right: 30, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const HomePage(
                                initialIndex: 1,
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35, bottom: 40),
                        child: Text(
                          'Create Memory',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 34,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                    },
                    child: Container(
                      height: 162,
                      width: 292,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 234, 253, 238),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: _image == null
                          ? const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Upload a photo',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Icon(
                                    Icons.add_a_photo,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            )
                          : ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 45, top: 30),
                    child: Container(
                      height: 210,
                      width: 292,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 35, right: 35, top: 10, bottom: 10),
                        child: TextFormField(
                          onChanged: (value) {
                            textMemory = value;
                          },
                          maxLines: 7,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Create your memory...',
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
                  Container(
                    height: 46,
                    width: 141,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 131, 159, 128),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextButton(
                      onPressed: () {
                        completeTask();
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
