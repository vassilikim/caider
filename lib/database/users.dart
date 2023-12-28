import 'dart:io';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final List<dynamic> tasks;
  final File profileImage;
  final int level;
  final int points;

  User(
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.password,
    this.tasks,
    this.profileImage,
    this.level,
    this.points,
  );

  // Convert user object to a Map
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'tasks': tasks,
      'profileImage': profileImage,
      'level': level,
      'points': points
    };
  }

  // Create a user object from a Map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        json['firstName'],
        json['lastName'],
        json['email'],
        json['phoneNumber'],
        json['password'],
        json['tasks'] != null ? List<int>.from(json['tasks']) : [],
        json['profileImage'],
        json['level'],
        json['points']);
  }
}
