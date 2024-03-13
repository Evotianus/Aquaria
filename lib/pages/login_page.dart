import 'package:aquaria/classes/user.dart';
import 'package:aquaria/features/utils.dart';
import 'package:aquaria/functions/functions.dart';
import 'package:aquaria/pages/home_page.dart';
import 'package:aquaria/pages/register_page.dart';
import 'package:aquaria/widgets/bubble_text_field.dart';
import 'package:aquaria/widgets/main_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkTheme ? darkBlueColor : blueColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 160),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/logo.png"),
              ),
              const SizedBox(
                height: 110,
              ),
              BubbleTextField(
                icon: Icons.person_2_outlined,
                controller: _usernameController,
                label: "Enter your username...",
                textIconColor: isDarkTheme ? Colors.white : orangeColor,
                color: isDarkTheme ? Colors.white.withOpacity(0.35) : Colors.white.withOpacity(0.3),
              ),
              const SizedBox(
                height: 25,
              ),
              BubbleTextField(
                icon: Icons.lock_outline_rounded,
                controller: _passwordController,
                type: "password",
                label: "Enter your password...",
                textIconColor: isDarkTheme ? Colors.white : orangeColor,
                color: isDarkTheme ? Colors.white.withOpacity(0.35) : Colors.white.withOpacity(0.3),
              ),
              const SizedBox(
                height: 45,
              ),
              MainButton(
                onTap: () async {
                  // For deployment purposes
                  final username = _usernameController.text;
                  final password = _passwordController.text;

                  final response = await loginUser(username, password);

                  if (response is User) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const HomePage(),
                      ),
                    );
                  } else {
                    print("Login Failed!");
                  }

                  // // For development purposes
                  // final response = await loginUser("Evos", "evo");

                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) {
                  //       return const HomePage();
                  //     },
                  //   ),
                  // );
                },
                label: "Log In",
                isDark: isDarkTheme ? true : false,
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: isDarkTheme ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: isDarkTheme ? lightBlueButtonBorderColor : orangeColor,
                        decoration: TextDecoration.underline,
                        decorationColor: isDarkTheme ? lightBlueButtonBorderColor : orangeColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
