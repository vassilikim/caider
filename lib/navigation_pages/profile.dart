import 'package:caider/auth/login.dart';
import 'package:caider/minor_pages/edit_profile.dart';
import 'package:caider/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  void logout() async {
    user = {};
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }));
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      if (justProfileSaved) {
        MyMessageHandler.showSnackbar(
            context,
            _scaffoldKey,
            'Your profile has been updated.',
            const Color.fromARGB(255, 168, 190, 163),
            isInHomePage: true);
      }
      setState(() {
        justProfileSaved = false;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        logout();
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 131, 159, 128),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Logout',
                                style: TextStyle(
                                    fontFamily: 'Roboto', fontSize: 14),
                              ),
                              Icon(
                                Icons.logout_rounded,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              CircularPercentIndicator(
                radius: 70.0,
                lineWidth: 8,
                percent: user['points'] / 100,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  'Level ${user['level']}',
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 22,
                  ),
                ),
                progressColor: const Color.fromARGB(255, 62, 136, 91),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 120),
                child: Container(
                  height: 254,
                  width: 293,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const EditProfilePage();
                            }));
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(255, 203, 222, 199),
                                radius: 50,
                                backgroundImage: user['profileImage'].path ==
                                        "null"
                                    ? const AssetImage('./assets/profile.png')
                                    : FileImage(user['profileImage'])
                                        as ImageProvider,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      '${user['firstName']} ${user['lastName']}',
                                      style: const TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      '${user['email']}',
                                      style: const TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      '${user['phoneNumber']}',
                                      style: const TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
