import 'package:flutter/material.dart';
import 'package:aquaria/pages/settings_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final Color blueColor = Color(0xff00B4ED);

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
                builder: (BuildContext context) => SettingsPage(),
              ),
            );
          },
          child: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 25),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                  padding: const EdgeInsets.fromLTRB(15, 50, 15, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'evotianus',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.phishing_rounded,
                                color: blueColor,
                                size: 35,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      width: 2.5,
                                      color: Color(0xffEEEEEE),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  '95%',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff308BCB),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.waves,
                                color: blueColor,
                                size: 35,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      width: 2.5,
                                      color: Color(0xffEEEEEE),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  '20',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff308BCB),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                MdiIcons.fish,
                                color: blueColor,
                                size: 35,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Text(
                                  '3/5',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff308BCB),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  top: -100,
                  child: Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: const Image(
                        image: AssetImage("assets/evotianus.png"),
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: Column(
                children: [
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
                          onTap: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Change Profile Picture',
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
                          onTap: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Change Name',
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
                          onTap: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Change E-Mail',
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
                          onTap: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Reset Password',
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
                          onTap: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delete Account',
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
    );
  }
}
