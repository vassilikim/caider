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
  Task(
      "Task 1",
      "We are looking for a skilled Flutter developer to implement a new feature in Project X. The task involves creating a dynamic user interface that fetches data from our backend server and displays it in an organized and visually appealing manner. You will need to use advanced state management techniques and integrate API calls to ensure seamless data retrieval and updates. The feature should also maintain responsiveness across various device sizes. Attention to detail and adherence to design specifications are crucial. The successful completion of this task will significantly enhance the overall functionality and user experience of Project X.",
      37.7749,
      -122.4194,
      40,
      1),
  Task(
      "Task 2",
      "We need a Flutter developer to update the styling of the primary action button in our app. This involves modifying the button's color, size, and font to align with our updated design guidelines.",
      43.7749,
      10.4194,
      10,
      1),
  Task(
      "Task 3",
      "We are looking for a skilled Flutter developer to implement a new feature in Project X. The task involves creating a dynamic user interface that fetches data from our backend server and displays it in an organized and visually appealing manner. You will need to use advanced state management techniques and integrate API calls to ensure seamless data retrieval and updates. The feature should also maintain responsiveness across various device sizes. Attention to detail and adherence to design specifications are crucial. The successful completion of this task will significantly enhance the overall functionality and user experience of Project X.",
      4.7749,
      1.4194,
      30,
      1),
  Task(
      "Task 4",
      "Complete a detailed research report on emerging technologies in artificial intelligence and present key findings in a concise presentation. Highlight the potential applications and impact on various industries. Ensure to include the latest trends, challenges, and opportunities in the AI landscape.",
      46.7749,
      10.4194,
      50,
      2),
  Task(
      "Task 5",
      "Complete a detailed research report on emerging technologies in artificial intelligence and present key findings in a concise presentation. Highlight the potential applications and impact on various industries. Ensure to include the latest trends, challenges, and opportunities in the AI landscape.",
      46.7749,
      10.4194,
      50,
      2),
  Task(
      "Task 6",
      "Complete a detailed research report on emerging technologies in artificial intelligence and present key findings in a concise presentation. Highlight the potential applications and impact on various industries. Ensure to include the latest trends, challenges, and opportunities in the AI landscape.",
      46.7749,
      10.4194,
      50,
      3),
  Task(
      "Task 7",
      "Complete a detailed research report on emerging technologies in artificial intelligence and present key findings in a concise presentation. Highlight the potential applications and impact on various industries. Ensure to include the latest trends, challenges, and opportunities in the AI landscape.",
      46.7749,
      10.4194,
      50,
      3),
  Task(
      "Task 8",
      "Complete a detailed research report on emerging technologies in artificial intelligence and present key findings in a concise presentation. Highlight the potential applications and impact on various industries. Ensure to include the latest trends, challenges, and opportunities in the AI landscape.",
      46.7749,
      10.4194,
      50,
      3)
];
