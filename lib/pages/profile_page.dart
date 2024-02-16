import 'package:aquaria/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:aquaria/pages/settings_page.dart';
import 'package:aquaria/features/utils.dart';
import 'package:aquaria/widgets/bubble_button.dart';
import 'package:http/http.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:aquaria/classes/user.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color blueColor = Color(0xff00B4ED);
  TextEditingController _changeNameTextController = TextEditingController();
  TextEditingController _changeEmailTextController = TextEditingController();
  TextEditingController _changeOldPasswordTextController = TextEditingController();
  TextEditingController _changePasswordTextController = TextEditingController();
  TextEditingController _changeConfirmPasswordTextController = TextEditingController();

  OverlayPortalController _changeNameController = OverlayPortalController();
  OverlayPortalController _changeEmailController = OverlayPortalController();
  OverlayPortalController _changePasswordController = OverlayPortalController();

  bool isOpenedPopUp = false;
  bool isPasswordConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(isOpenedPopUp ? 0.5 : 0),
                BlendMode.darken,
              ),
              child: AbsorbPointer(
                absorbing: isOpenedPopUp ? true : false,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0xffEEEEEE),
                  child: Column(
                    children: [
                      Padding(
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
                                      Text(
                                        currentUser!.username!,
                                        style: const TextStyle(
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
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _changeNameController.show();
                                        _changeNameTextController.text = currentUser!.username!;
                                        isOpenedPopUp = true;
                                      });
                                    },
                                    child: Container(
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
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Change Username',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff808080),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                            setState(() {
                                              _changeEmailController.show();
                                              _changeEmailTextController.text = currentUser!.email!;
                                              isOpenedPopUp = true;
                                            });
                                          },
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
                                          onTap: () {
                                            setState(() {
                                              _changePasswordController.show();
                                              isOpenedPopUp = true;
                                            });
                                          },
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
                    ],
                  ),
                ),
              ),
            ),
            OverlayPortal(
              controller: _changeNameController,
              overlayChildBuilder: (BuildContext context) {
                return Positioned(
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                        width: 365,
                        height: 285,
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Change Username",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BubbleButton(
                              color: Colors.white.withOpacity(0.3),
                              textColor: orangeColor.withOpacity(0.75),
                              label: currentUser!.username!,
                              length: 300,
                              controller: _changeNameTextController,
                              type: 'TextField',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BubbleButton(
                              color: Colors.white.withOpacity(0.3),
                              textColor: orangeColor.withOpacity(0.75),
                              label: "Confirm Password",
                              length: 300,
                              controller: _changeConfirmPasswordTextController,
                              type: 'Password',
                            ),
                            Opacity(
                              opacity: isPasswordConfirmed ? 1.0 : 0.0,
                              child: const Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.error_outline,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Wrong password",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _changeNameController.hide();
                                    setState(() {
                                      isOpenedPopUp = false;
                                    });
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white.withOpacity(0.75),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final responseVerify = await loginUser(currentUser!.username, _changeConfirmPasswordTextController.text);

                                    if (responseVerify is User) {
                                      isPasswordConfirmed = false;
                                      final response = await changeName(_changeNameTextController.text);
                                      _changeNameController.hide();
                                      setState(() {
                                        isOpenedPopUp = false;
                                        _changeConfirmPasswordTextController.text = '';
                                      });
                                    } else {
                                      setState(() {
                                        isPasswordConfirmed = true;
                                        _changeNameTextController.text = currentUser!.username!;
                                        _changeConfirmPasswordTextController.text = '';
                                      });
                                    }
                                  },
                                  child: BubbleButton(
                                    color: const Color(0xffFF7E4C),
                                    secondaryColor: orangeColor,
                                    label: 'Done',
                                    length: 90,
                                    textColor: Colors.white,
                                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            OverlayPortal(
              controller: _changeEmailController,
              overlayChildBuilder: (BuildContext context) {
                return Positioned(
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                        width: 365,
                        height: 285,
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Change E-Mail",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BubbleButton(
                              color: Colors.white.withOpacity(0.3),
                              textColor: orangeColor.withOpacity(0.75),
                              label: currentUser!.email!,
                              length: 300,
                              controller: _changeEmailTextController,
                              type: 'TextField',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BubbleButton(
                              color: Colors.white.withOpacity(0.3),
                              textColor: orangeColor.withOpacity(0.75),
                              label: "Confirm Password",
                              length: 300,
                              controller: _changeConfirmPasswordTextController,
                              type: 'Password',
                            ),
                            Opacity(
                              opacity: isPasswordConfirmed ? 1.0 : 0.0,
                              child: const Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.error_outline,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Wrong password",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _changeEmailController.hide();
                                    setState(() {
                                      isOpenedPopUp = false;
                                    });
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white.withOpacity(0.75),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final responseVerify = await loginUser(currentUser!.username, _changeConfirmPasswordTextController.text);

                                    if (responseVerify is User) {
                                      isPasswordConfirmed = false;
                                      final response = await changeEmail(_changeEmailTextController.text);
                                      _changeEmailController.hide();
                                      setState(() {
                                        isOpenedPopUp = false;
                                        _changeConfirmPasswordTextController.text = '';
                                      });
                                    } else {
                                      setState(() {
                                        isPasswordConfirmed = true;
                                        _changeConfirmPasswordTextController.text = '';
                                      });
                                    }
                                  },
                                  child: BubbleButton(
                                    color: const Color(0xffFF7E4C),
                                    secondaryColor: orangeColor,
                                    label: 'Done',
                                    length: 90,
                                    textColor: Colors.white,
                                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            OverlayPortal(
              controller: _changePasswordController,
              overlayChildBuilder: (BuildContext context) {
                return Positioned(
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                        width: 365,
                        height: 355,
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Change E-Mail",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BubbleButton(
                              color: Colors.white.withOpacity(0.3),
                              textColor: orangeColor.withOpacity(0.75),
                              label: "Old Password",
                              length: 300,
                              controller: _changeOldPasswordTextController,
                              type: 'Password',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BubbleButton(
                              color: Colors.white.withOpacity(0.3),
                              textColor: orangeColor.withOpacity(0.75),
                              label: "New Password",
                              length: 300,
                              controller: _changePasswordTextController,
                              type: 'Password',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BubbleButton(
                              color: Colors.white.withOpacity(0.3),
                              textColor: orangeColor.withOpacity(0.75),
                              label: "Confirm Password",
                              length: 300,
                              controller: _changeConfirmPasswordTextController,
                              type: 'Password',
                            ),
                            Opacity(
                              opacity: isPasswordConfirmed ? 1.0 : 0.0,
                              child: const Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.error_outline,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Wrong password",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _changePasswordController.hide();
                                    setState(() {
                                      isOpenedPopUp = false;
                                    });
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white.withOpacity(0.75),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (_changeConfirmPasswordTextController.text == _changePasswordTextController.text) {
                                      final responseVerify = await loginUser(currentUser!.username, _changeOldPasswordTextController.text);

                                      if (responseVerify is User) {
                                        isPasswordConfirmed = false;
                                        final response = await changePassword(_changePasswordTextController.text);
                                        _changePasswordController.hide();
                                        setState(() {
                                          isOpenedPopUp = false;
                                          _changeConfirmPasswordTextController.text = '';
                                        });
                                      } else {
                                        setState(() {
                                          isPasswordConfirmed = true;
                                          _changeConfirmPasswordTextController.text = '';
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        isPasswordConfirmed = true;
                                        _changeOldPasswordTextController.text = '';
                                        _changePasswordTextController.text = '';
                                        _changeConfirmPasswordTextController.text = '';
                                      });
                                    }
                                  },
                                  child: BubbleButton(
                                    color: const Color(0xffFF7E4C),
                                    secondaryColor: orangeColor,
                                    label: 'Done',
                                    length: 90,
                                    textColor: Colors.white,
                                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
