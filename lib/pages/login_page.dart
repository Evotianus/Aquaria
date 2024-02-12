import 'package:aquaria/classes/user.dart';
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
      backgroundColor: const Color(0xff00B4ED),
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
              ),
              const SizedBox(
                height: 25,
              ),
              BubbleTextField(
                icon: Icons.lock_outline_rounded,
                controller: _passwordController,
                type: "password",
                label: "Enter your password...",
              ),
              const SizedBox(
                height: 45,
              ),
              MainButton(
                onTap: () async {
                  // // For deployment purposes
                  // final username = _usernameController.text;
                  // final password = _passwordController.text;

                  // final response = await loginUser(username, password);

                  // if (response is User) {
                  //   Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(
                  //       builder: (BuildContext context) => const HomePage(),
                  //     ),
                  //   );
                  // } else {
                  //   print("Login Failed!");
                  // }

                  // For development purposes
                  final response = await loginUser("Evo", "evo");

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return HomePage();
                      },
                    ),
                  );
                },
                label: "Log In",
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
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
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xffFE4600),
                        decoration: TextDecoration.underline,
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
