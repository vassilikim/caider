import 'dart:io';

import 'package:caider/database/tasks.dart';
import 'package:caider/database/users.dart';

List<User> users = [
  User(
      "Vassiliki",
      "Missiri",
      "vassiliki@email.com",
      "6946694502",
      "test",
      [
        {
          "task": Task("Task 1", "test desc", 37.7749, -122.4194, 40, 1),
          "status": "to_do"
        }
      ],
      File("null"),
      1,
      60)
];

List<Task> tasks = [
  Task("Task 1", "test desc", 37.7749, -122.4194, 40, 1),
  Task("Task 2", "test desc", 43.7749, 10.4194, 10, 1),
  Task("Task 3", "test desc", 4.7749, 1.4194, 30, 1),
  Task("Task 4", "test desc", 46.7749, 10.4194, 50, 2),
  Task("Task 5", "test desc", 46.7749, 10.4194, 50, 2),
  Task("Task 6", "test desc", 46.7749, 10.4194, 50, 3),
  Task("Task 7", "test desc", 46.7749, 10.4194, 50, 3),
  Task("Task 8", "test desc", 46.7749, 10.4194, 50, 3)
];
