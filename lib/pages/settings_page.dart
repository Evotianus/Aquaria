import 'package:aquaria/pages/homepage.dart';
import 'package:aquaria/pages/privacy_policy_page.dart';
import 'package:aquaria/pages/profile_page.dart';
import 'package:aquaria/pages/terms_of_use_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Color blueColor = Color(0xff00B4ED);
  bool isConfirm = false;
  bool isEnableNotification = false;
  bool isAnimationSound = false;
  bool isCompletionSound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: blueColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => const HomePage(),
              ),
            );
          },
          child: const Icon(Icons.close),
        ),
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => ProfilePage(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: const Image(
                          image: AssetImage("assets/evotianus.png"),
                          width: 80,
                          height: 80,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'evotianus',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('evotianus0110@gmail.com',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: blueColor,
                                fontSize: 14,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 70,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 7),
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              bottom: BorderSide(
                                width: 2.0,
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                MdiIcons.cogOutline,
                                size: 35,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'General',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 70,
                          padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              bottom: BorderSide(
                                width: 2.0,
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Confirm Before Deleting',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff808080),
                                ),
                              ),
                              Switch(
                                value: isConfirm,
                                activeColor: blueColor,
                                onChanged: (value) => {
                                  setState(() {
                                    isConfirm = value;
                                  })
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 70,
                          padding: EdgeInsets.fromLTRB(0, 21, 0, 21),
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              bottom: BorderSide(
                                width: 2.0,
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const HomePage(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Theme',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff808080),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 70,
                          padding: EdgeInsets.fromLTRB(0, 21, 0, 21),
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              bottom: BorderSide(
                                width: 2.0,
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Clear All Record',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff808080),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 70,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 7),
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              bottom: BorderSide(
                                width: 2.0,
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.notifications_outlined,
                                size: 35,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Sound & Notification',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 70,
                          padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              bottom: BorderSide(
                                width: 2.0,
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Enable Notification',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff808080),
                                ),
                              ),
                              Switch(
                                value: isEnableNotification,
                                activeColor: blueColor,
                                onChanged: (value) => {
                                  setState(() {
                                    isEnableNotification = value;
                                  })
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 70,
                          padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              bottom: BorderSide(
                                width: 2.0,
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Play Animation Sound',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff808080),
                                ),
                              ),
                              Switch(
                                value: isAnimationSound,
                                activeColor: blueColor,
                                onChanged: (value) => {
                                  setState(() {
                                    isAnimationSound = value;
                                  })
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 70,
                          padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              bottom: BorderSide(
                                width: 2.0,
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Play Completion Sound',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff808080),
                                ),
                              ),
                              Switch(
                                value: isCompletionSound,
                                activeColor: blueColor,
                                onChanged: (value) => {
                                  setState(() {
                                    isCompletionSound = value;
                                  })
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 70,
                          padding: EdgeInsets.fromLTRB(0, 21, 0, 21),
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              bottom: BorderSide(
                                width: 2.0,
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const HomePage(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Casting Reminder',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff808080),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 70,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 7),
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              bottom: BorderSide(
                                width: 2.0,
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                MdiIcons.dotsHorizontalCircleOutline,
                                size: 35,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Other',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 70,
                          padding: EdgeInsets.fromLTRB(0, 21, 0, 21),
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              bottom: BorderSide(
                                width: 2.0,
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const HomePage()),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Help',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff808080),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 70,
                          padding: EdgeInsets.fromLTRB(0, 21, 0, 21),
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              bottom: BorderSide(
                                width: 2.0,
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TermsOfUsePage()),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Terms of Use',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff808080),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 70,
                          padding: EdgeInsets.fromLTRB(0, 21, 0, 21),
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              bottom: BorderSide(
                                width: 2.0,
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PrivacyPolicyPage()),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff808080),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
