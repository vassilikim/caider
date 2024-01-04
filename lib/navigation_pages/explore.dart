import 'package:caider/auth/login.dart';
import 'package:caider/database/data.dart';
import 'package:caider/database/tasks.dart';
import 'package:caider/minor_pages/task_page.dart';
import 'package:caider/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  List<Task> exploreTasks = tasks
      .where((task) => !user['tasks']
          .map((task) => task['task'].toJson()['name'])
          .toList()
          .contains(task.toJson()['name']))
      .toList();

  @override
  void initState() {
    super.initState();
    Future(() async {
      if (justAcceptedTask) {
        MyMessageHandler.showSnackbar(
            context,
            _scaffoldKey,
            'The task has been accepted.',
            const Color.fromARGB(255, 168, 190, 163),
            isInHomePage: true);
      }
      setState(() {
        justAcceptedTask = false;
      });
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
                        'Tasks',
                        style: TextStyle(fontFamily: 'Roboto', fontSize: 34),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: exploreTasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool isLocked =
                          user['level'] < exploreTasks[index].toJson()['level'];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: isLocked
                              ? null
                              : () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return TaskPage(
                                      currentTask: exploreTasks[index],
                                      pageFrom: 0,
                                    );
                                  }));
                                },
                          child: Container(
                            height: 95,
                            width: 293,
                            decoration: BoxDecoration(
                              color: isLocked
                                  ? const Color.fromARGB(200, 234, 253,
                                      238) // Dull color for locked task
                                  : const Color.fromARGB(255, 234, 253, 238),
                              borderRadius: const BorderRadius.all(
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
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: SizedBox(
                                      width: 160,
                                      child: Text(
                                        exploreTasks[index].toJson()['name'],
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 17,
                                            overflow: TextOverflow.ellipsis,
                                            color: isLocked
                                                ? Colors.grey
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                  isLocked
                                      ? const Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Icons.lock,
                                            color: Colors.grey,
                                          ),
                                        )
                                      : const CircleAvatar(
                                          backgroundColor: Color.fromARGB(
                                              255, 131, 159, 128),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
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
