import 'package:caider/navigation_pages/completed.dart';
import 'package:caider/navigation_pages/explore.dart';
import 'package:caider/navigation_pages/profile.dart';
import 'package:caider/navigation_pages/to_do.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const ExplorePage(),
    const ToDoPage(),
    const CompletedPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 203, 222, 199),
      bottomNavigationBar: Container(
        height: 65,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: const Color.fromARGB(255, 131, 159, 128),
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 13,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 13,
            ),
            selectedItemColor: Colors.black,
            currentIndex: _selectedIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'To do',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.task_alt),
                label: 'Completed',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
      body: _tabs[_selectedIndex],
    );
  }
}
