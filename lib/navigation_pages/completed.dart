import 'package:caider/auth/login.dart';
import 'package:caider/minor_pages/task_page.dart';
import 'package:flutter/material.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key});

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  List<dynamic> completedTasks = user['tasks']
      .where((task) => task["status"] == "completed")
      .map((task) => task['task'])
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'My Tasks',
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 34),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: completedTasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return TaskPage(
                              currentTask: completedTasks[index],
                              pageFrom: 2,
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
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                    width: 160,
                                    child: Text(
                                      completedTasks[index].toJson()['name'],
                                      style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 17,
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                const CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 131, 159, 128),
                                  child: Icon(
                                    Icons.memory_rounded,
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
    );
  }
}
