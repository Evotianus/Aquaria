import 'package:aquaria/features/utils.dart';
import 'package:aquaria/pages/home_page.dart';
import 'package:aquaria/pages/login_page.dart';
import 'package:aquaria/widgets/bubble_text_field.dart';
import 'package:aquaria/widgets/main_button.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkTheme ? darkBlueColor : blueColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 140),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/logo.png"),
                height: 90,
              ),
              const SizedBox(
                height: 80,
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
                icon: Icons.mail_outline_rounded,
                controller: _emailController,
                label: "Enter your email...",
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
                height: 25,
              ),
              BubbleTextField(
                icon: Icons.lock_reset_rounded,
                controller: _confirmPasswordController,
                type: "password",
                label: "Confirm your password...",
                textIconColor: isDarkTheme ? Colors.white : orangeColor,
                color: isDarkTheme ? Colors.white.withOpacity(0.35) : Colors.white.withOpacity(0.3),
              ),
              const SizedBox(
                height: 45,
              ),
              MainButton(
                onTap: () async {
                  // // For deployment purposes
                  // final username = _usernameController.text;
                  // final email = _emailController.text;
                  // final password = _passwordController.text;
                  // final confirmPassword = _confirmPasswordController.text;

                  // final response = await registerUser(
                  //     username, email, password, confirmPassword);

                  // if (response == 200) {
                  //   Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(
                  //       builder: (BuildContext context) => const HomePage(),
                  //     ),
                  //   );
                  // } else if (response == 400) {
                  //   print("Password doesn't match!");
                  // } else {
                  //   print("Server trouble!");
                  // }

                  // For development purposes
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const HomePage(),
                    ),
                  );
                },
                label: "Sign Up",
                isDark: isDarkTheme ? true : false,
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
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
                          builder: (BuildContext context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: isDarkTheme ? lightBlueButtonBorderColor : orangeColor,
                        decoration: TextDecoration.underline,
                        decorationColor: isDarkTheme ? lightBlueButtonBorderColor : orangeColor,
                      ),
                    ),
                  ),
                ],
              ),
              // const Positioned(
              //   bottom: 0,
              //   left: 0,
              //   width: 100,
              //   height: 100,
              //   child: Image(
              //     image: AssetImage("assets/waves.png"),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
