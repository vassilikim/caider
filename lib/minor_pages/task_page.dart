import 'dart:io';

import 'package:caider/auth/login.dart';
import 'package:caider/database/data.dart';
import 'package:caider/database/tasks.dart';
import 'package:caider/database/users.dart';
import 'package:caider/home.dart';
import 'package:caider/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

bool justAcceptedTask = false;

class TaskPage extends StatefulWidget {
  final Task currentTask;
  const TaskPage({super.key, required this.currentTask});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  void launchGoogleMaps(double latitude, double longitude) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  void acceptTask() async {
    User currentUser = users.firstWhere(
      (user1) => user1.toJson()["email"] == user['email'],
      orElse: () =>
          User("null", "null", "null", "null", "null", [], File("null"), 0, 0),
    );
    if (currentUser.toJson()["email"] == "null") {
      return MyMessageHandler.showSnackbar(context, _scaffoldKey,
          'Something went wrong!.', const Color.fromARGB(255, 238, 150, 150));
    }

    users.removeWhere((user1) => user1.toJson()["email"] == user['email']);

    List<dynamic> updatedTasks = [
      ...currentUser.toJson()['tasks'],
      {"task": widget.currentTask, "status": "to_do"}
    ];

    User updatedUser = User(
        currentUser.toJson()['firstName'],
        currentUser.toJson()['lastName'],
        currentUser.toJson()['email'],
        currentUser.toJson()['phoneNumber'],
        currentUser.toJson()['password'],
        updatedTasks,
        currentUser.toJson()['profileImage'],
        currentUser.toJson()['level'],
        currentUser.toJson()['points']);
    users.add(updatedUser);

    user = updatedUser.toJson();

    setState(() {
      justAcceptedTask = true;
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const HomePage(
        initialIndex: 0,
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
            initialIndex: 0,
          );
        }));
      },
      child: ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 203, 222, 199),
          body: Center(
            child: SingleChildScrollView(
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
                                initialIndex: 0,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 35, bottom: 25),
                        child: Text(
                          widget.currentTask.toJson()['name'],
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 34,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(30),
                              child: Text(
                                widget.currentTask.toJson()['description'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: GestureDetector(
                      onTap: () {
                        launchGoogleMaps(
                            widget.currentTask.toJson()['latitude'],
                            widget.currentTask.toJson()['longitude']);
                      },
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            color: Colors.white),
                        // child: FlutterMap(
                        //   options: MapOptions(
                        //     interactionOptions:
                        //         const InteractionOptions(flags: InteractiveFlag.none),
                        //     initialCenter: LatLng(
                        //         widget.currentTask.toJson()['latitude'],
                        //         widget.currentTask.toJson()['longitude']),
                        //     initialZoom: 9.2,
                        //     backgroundColor: const Color.fromARGB(255, 203, 222, 199),
                        //   ),
                        //   children: [
                        //     TileLayer(
                        //       urlTemplate:
                        //           'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        //       userAgentPackageName: 'com.example.app',
                        //     ),
                        //   ],
                        // ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Container(
                      height: 46,
                      width: 141,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 131, 159, 128),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextButton(
                        onPressed: () {
                          acceptTask();
                        },
                        child: const Text(
                          'Accept',
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
