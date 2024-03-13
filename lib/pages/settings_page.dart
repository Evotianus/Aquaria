import 'package:aquaria/functions/functions.dart';
import 'package:aquaria/pages/help_page.dart';
import 'package:aquaria/pages/home_page.dart';
import 'package:aquaria/pages/privacy_policy_page.dart';
import 'package:aquaria/pages/profile_page.dart';
import 'package:aquaria/pages/terms_of_use_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:aquaria/features/utils.dart';
import 'package:aquaria/classes/user.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkTheme ? darkBlueColor : blueColor,
      appBar: AppBar(
        backgroundColor: const Color(0xff07D0FC),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => const HomePage(),
              ),
            );
          },
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
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
                          Text(
                            currentUser!.username!,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
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
              const SizedBox(
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
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
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
                          padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
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
                                value: isConfirmDelete,
                                inactiveThumbColor: orangeColor,
                                inactiveTrackColor: orangeColor.withOpacity(0.5),
                                activeColor: blueColor,
                                onChanged: (value) => {
                                  setState(() {
                                    isConfirmDelete = value;
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
                          padding: const EdgeInsets.fromLTRB(0, 21, 0, 21),
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
                                  builder: (BuildContext context) => const HomePage(),
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
                                Switch(
                                  value: isDarkTheme,
                                  inactiveThumbColor: orangeColor,
                                  inactiveTrackColor: orangeColor.withOpacity(0.5),
                                  activeColor: blueColor,
                                  onChanged: (value) => {
                                    setState(() {
                                      isDarkTheme = value;
                                    })
                                  },
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
                          padding: const EdgeInsets.fromLTRB(0, 21, 0, 21),
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              bottom: BorderSide(
                                width: 2.0,
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
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
              const SizedBox(
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
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              bottom: BorderSide(
                                width: 2.0,
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.notifications_outlined,
                                size: 35,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
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
                          padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
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
                                inactiveThumbColor: orangeColor,
                                inactiveTrackColor: orangeColor.withOpacity(0.5),
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
                          padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
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
                                inactiveThumbColor: orangeColor,
                                inactiveTrackColor: orangeColor.withOpacity(0.5),
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
                          padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
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
                                inactiveThumbColor: orangeColor,
                                inactiveTrackColor: orangeColor.withOpacity(0.5),
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
                          padding: const EdgeInsets.fromLTRB(0, 21, 0, 21),
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
                                  builder: (BuildContext context) => const HomePage(),
                                ),
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
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
              const SizedBox(
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
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
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
                          padding: const EdgeInsets.fromLTRB(0, 21, 0, 21),
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
                                MaterialPageRoute(builder: (BuildContext context) => const HelpPage()),
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
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
                          padding: const EdgeInsets.fromLTRB(0, 21, 0, 21),
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
                                MaterialPageRoute(builder: (BuildContext context) => TermsOfUsePage()),
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
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
                          padding: const EdgeInsets.fromLTRB(0, 21, 0, 21),
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
                                MaterialPageRoute(builder: (BuildContext context) => PrivacyPolicyPage()),
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
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
