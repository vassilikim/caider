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
          "task": Task(
              "Protect Sea Turtles on Zakynthos",
              "Volunteer with an organization that works to protect endangered sea turtles on Zakynthos Island. Help monitor nesting beaches, clean up marine debris, and rescue injured turtles.",
              "task1.png",
              20,
              1,
              "https://www.google.com/maps/place/%CE%96%CE%AC%CE%BA%CF%85%CE%BD%CE%B8%CE%BF%CF%82/@37.785324,20.8848125,13.89z/data=!4m6!3m5!1s0x136747d9efb0afbd:0xdbba1265b653379a!8m2!3d37.7881604!4d20.8988271!16zL20vMDlsZzZx?entry=ttu"),
          "status": "to_do"
        }
      ],
      File("null"),
      1,
      90)
];

List<Task> tasks = [
  Task(
      "Protect Sea Turtles on Zakynthos",
      "Volunteer with an organization that works to protect endangered sea turtles on Zakynthos Island. Help monitor nesting beaches, clean up marine debris, and rescue injured turtles.",
      "task1.png",
      20,
      1,
      "https://www.google.com/maps/place/%CE%96%CE%AC%CE%BA%CF%85%CE%BD%CE%B8%CE%BF%CF%82/@37.785324,20.8848125,13.89z/data=!4m6!3m5!1s0x136747d9efb0afbd:0xdbba1265b653379a!8m2!3d37.7881604!4d20.8988271!16zL20vMDlsZzZx?entry=ttu"),
  Task(
      "Explore the Ancient Ruins of Olympia",
      "Volunteer with a group that excavates and preserves the ancient Olympic Games site in Olympia. Help uncover artifacts, document findings, and share the history of ancient Greece.",
      "task2.png",
      50,
      1,
      "https://www.google.com/maps/place/%CE%91%CF%81%CF%87%CE%B1%CE%B9%CE%BF%CE%BB%CE%BF%CE%B3%CE%B9%CE%BA%CF%8C%CF%82+%CE%A7%CF%8E%CF%81%CE%BF%CF%82+%CE%9F%CE%BB%CF%85%CE%BC%CF%80%CE%AF%CE%B1%CF%82/@37.6387037,17.4112701,7z/data=!4m10!1m2!2m1!1sAncient+Ruins+of+Olympia!3m6!1s0x136092ef583187f3:0x998b4c652e12df7!8m2!3d37.6384588!4d21.6298796!15sChhBbmNpZW50IFJ1aW5zIG9mIE9seW1waWFaGiIYYW5jaWVudCBydWlucyBvZiBvbHltcGlhkgENaGlzdG9yaWNfc2l0ZZoBI0NoWkRTVWhOTUc5blMwVkpRMEZuU1VOU05VNWlaR04zRUFF4AEA!16zL20vMDFzd2xm?entry=ttu"),
  Task(
      "Restore Traditional Greek Crafts",
      "Volunteer with a workshop that preserves traditional Greek crafts, such as wood carving, weaving, or pottery. Learn the techniques and help create unique handmade products.",
      "task3.png",
      30,
      1,
      "https://www.google.com/maps/place/%CE%9C%CE%AD%CF%84%CF%83%CE%BF%CE%B2%CE%BF+442+00/@39.7727305,21.1723144,15z/data=!3m1!4b1!4m6!3m5!1s0x13596350e1138389:0xddae3e8f90e0788e!8m2!3d39.7702467!4d21.1828612!16zL20vMDM4cWRf?entry=ttu"),
  Task(
      "Assist at the Meteora Monasteries",
      "Volunteer to help maintain the ancient monasteries perched atop towering rock formations in Meteora. Assist with cleaning, restoration, and visitor services.",
      "task4.png",
      40,
      2,
      "https://www.google.com/maps/place/%CE%9C%CE%B5%CF%84%CE%AD%CF%89%CF%81%CE%B1/@39.7217044,21.6141101,15z/data=!4m10!1m2!2m1!1s+Meteora,+Central+Greece!3m6!1s0x13590faee8327f39:0x7127add4d8bc32ff!8m2!3d39.7217044!4d21.6305896!15sChdNZXRlb3JhLCBDZW50cmFsIEdyZWVjZVoYIhZtZXRlb3JhIGNlbnRyYWwgZ3JlZWNlkgEJbW9uYXN0ZXJ5mgEjQ2haRFNVaE5NRzluUzBWSlEwRm5TVVE0YWpsbE5VTm5FQUXgAQA!16zL20vMDEyZDl6?entry=ttu"),
  Task(
      "Document the Caves of Petralona",
      "Volunteer with a group that documents and explores the ancient caves of Petralona, located near Thessaloniki. Help record and analyze cave formations, fossils, and archaeological findings.",
      "task5.png",
      60,
      2,
      "https://www.google.com/maps/place/%CE%A3%CF%80%CE%AE%CE%BB%CE%B1%CE%B9%CE%BF+%CE%A0%CE%B5%CF%84%CF%81%CE%B1%CE%BB%CF%8E%CE%BD%CF%89%CE%BD/@40.3747976,21.0587311,8z/data=!4m10!1m2!2m1!1sCaves+of+Petralona!3m6!1s0x14a1bce4b1962f07:0x1407122ac7611f40!8m2!3d40.3748923!4d23.1679928!15sChJDYXZlcyBvZiBQZXRyYWxvbmFaFCISY2F2ZXMgb2YgcGV0cmFsb25hkgETaGlzdG9yaWNhbF9sYW5kbWFya-ABAA!16s%2Fm%2F0j45cz2?entry=ttu"),
  Task(
      "Animal Shelter Assistance",
      "Contribute your time to local animal shelters by volunteering in tasks such as animal care, cleaning, organizing adoption events, and fundraising to support the welfare of animals in need.",
      "task6.png",
      50,
      3,
      "https://www.google.com/maps/place/%CE%98%CE%B5%CF%83%CF%83%CE%B1%CE%BB%CE%BF%CE%BD%CE%AF%CE%BA%CE%B7/@40.6211852,22.9048276,13z/data=!3m1!4b1!4m6!3m5!1s0x14a838f41428e0ed:0x9bae715b8d574a9!8m2!3d40.6400629!4d22.9444191!16zL20vMGIybWM?entry=ttu"),
  Task(
      "Forest Conservation and Monitoring",
      "Participate in projects aimed at conserving forests and protecting the habitats of wildlife in areas like Pindus National Park. Tasks may include trail maintenance, invasive species removal, and wildlife tracking.",
      "task7.png",
      50,
      3,
      "https://www.google.com/maps/place/%CE%95%CE%B8%CE%BD%CE%B9%CE%BA%CF%8C+%CE%A0%CE%AC%CF%81%CE%BA%CE%BF+%CE%A0%CE%AF%CE%BD%CE%B4%CE%BF%CF%85/@39.941268,20.9482828,17z/data=!3m1!4b1!4m6!3m5!1s0x135bd3af32e3be93:0x9ce919195647e240!8m2!3d39.941268!4d20.9508577!16s%2Fg%2F119x36sn5?entry=ttu"),
  Task(
      "Mediterranean Monk Seal Protection",
      "Join initiatives dedicated to the protection of the critically endangered Mediterranean monk seal. Participate in monitoring activities, beach cleanups, and educational programs to raise awareness about the seal's conservation status.",
      "task8.png",
      50,
      3,
      "https://www.google.com/maps/place/%CE%91%CE%BB%CF%8C%CE%BD%CE%BD%CE%B7%CF%83%CE%BF%CF%82+370+05/@39.1498224,23.8425617,17z/data=!3m1!4b1!4m6!3m5!1s0x14a6940fc1e3f805:0x4ce2732d03a19d82!8m2!3d39.1496707!4d23.8438543!16s%2Fg%2F11swwbkggr?entry=ttu"),
  Task(
      "Immigrant School",
      "The specific school is an initiative of migrants and Greek volunteers, offering free Greek language lessons to working immigrants and refugees. Classes take place on weekends in Kolonos, and the volunteers include educators, students of pedagogical schools, and anyone who feels they can contribute to the effort.",
      "task9.png",
      50,
      4,
      "https://www.google.com/maps/place/%CE%9A%CE%BF%CE%BB%CF%89%CE%BD%CF%8C%CF%82,+%CE%91%CE%B8%CE%AE%CE%BD%CE%B1+104+44/@37.9944755,23.7026842,15z/data=!3m1!4b1!4m6!3m5!1s0x14a1bcd5f5a0dc41:0x2600bd2df93b4b02!8m2!3d37.9944764!4d23.7129839!16zL20vMDRobHp2?entry=ttu"),
  Task(
      "Bear Sanctuary Support",
      "Volunteer at the Arcturos Bear Sanctuary, dedicated to the rescue and rehabilitation of captive bears. Assist in daily care routines, including feeding, enrichment activities, and habitat maintenance. Participate in educational programs for visitors to raise awareness about bear conservation and the importance of preserving their natural habitats.",
      "task10.png",
      50,
      4,
      "https://www.google.com/maps/place/%CE%91%CE%A1%CE%9A%CE%A4%CE%9F%CE%A5%CE%A1%CE%9F%CE%A3+%CE%9A%CE%AD%CE%BD%CF%84%CF%81%CE%BF+%CE%A0%CF%81%CE%BF%CF%83%CF%84%CE%B1%CF%83%CE%AF%CE%B1%CF%82+%CE%9B%CF%8D%CE%BA%CE%BF%CF%85+%26+%CE%9B%CF%8D%CE%B3%CE%BA%CE%B1/@40.5359095,21.0930934,8.61z/data=!4m6!3m5!1s0x1357663032fde67d:0xd8e86a45abb77ecc!8m2!3d40.6391037!4d21.5319365!16s%2Fg%2F11c0r5k9h8?entry=ttu")
];
