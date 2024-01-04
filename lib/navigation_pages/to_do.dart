import 'dart:io';

import 'package:caider/auth/login.dart';
import 'package:caider/database/data.dart';
import 'package:caider/database/users.dart';
import 'package:caider/home.dart';
import 'package:caider/minor_pages/create_memory.dart';
import 'package:caider/minor_pages/task_page.dart';
import 'package:caider/widgets/snackbar.dart';
import 'package:flutter/material.dart';

bool justRemovedTask = false;

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  List<dynamic> toDoTasks = user['tasks']
      .where((task) => task["status"] == "to_do")
      .map((task) => task['task'])
      .toList();

  void removeTask(int taskIndex) async {
    User currentUser = users.firstWhere(
      (user1) => user1.toJson()["email"] == user['email'],
      orElse: () =>
          User("null", "null", "null", "null", "null", [], File("null"), 0, 0),
    );
    if (currentUser.toJson()["email"] == "null") {
      return MyMessageHandler.showSnackbar(context, _scaffoldKey,
          'Something went wrong!.', const Color.fromARGB(255, 238, 150, 150),
          isInHomePage: true);
    }

    users.removeWhere((user1) => user1.toJson()["email"] == user['email']);

    List<dynamic> updatedTasks = currentUser
        .toJson()['tasks']
        .where((task) =>
            task['task'].toJson()['name'] !=
            toDoTasks[taskIndex].toJson()['name'])
        .toList();

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
      justRemovedTask = true;
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const HomePage(
        initialIndex: 1,
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      if (justRemovedTask) {
        MyMessageHandler.showSnackbar(
            context,
            _scaffoldKey,
            'The task was successfully removed.',
            const Color.fromARGB(255, 168, 190, 163),
            isInHomePage: true);

        setState(() {
          justRemovedTask = false;
        });
      } else if (justCompletedTask) {
        MyMessageHandler.showSnackbar(
            context,
            _scaffoldKey,
            'You completed the task + $pointsGained points!',
            const Color.fromARGB(255, 168, 190, 163),
            isInHomePage: true);

        setState(() {
          justCompletedTask = false;
          pointsGained = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 203, 222, 199),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Accepted Tasks',
                        style: TextStyle(fontFamily: 'Roboto', fontSize: 34),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: toDoTasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return TaskPage(
                                currentTask: toDoTasks[index],
                                pageFrom: 1,
                              );
                            }));
                          },
                          child: Container(
                            height: 95,
                            width: 293,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 234, 253, 238),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      removeTask(index);
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 160,
                                    child: Text(
                                      toDoTasks[index].toJson()['name'],
                                      style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 17,
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CreateMemoryPage(
                                          currentTask: toDoTasks[index],
                                        );
                                      }));
                                    },
                                    icon: const Icon(
                                      Icons.done_all,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
