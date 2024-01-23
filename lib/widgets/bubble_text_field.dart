import 'package:flutter/material.dart';

class BubbleTextField extends StatelessWidget {
  IconData icon;
  TextEditingController controller;
  String label;
  String? type;

  BubbleTextField({
    super.key,
    required this.icon,
    required this.controller,
    required this.label,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            const Image(
              image: AssetImage("assets/icon-bubble.png"),
            ),
            Icon(
              icon,
              color: const Color(0xffFE4600),
              size: 30,
            )
          ],
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              const Image(
                image: AssetImage("assets/textfield-bubble.png"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  obscureText: (type == "password" ? true : false),
                  // enableSuggestions: (type == "password" ? false : true),
                  // autocorrect: (type == "password" ? false : true),
                  controller: controller,
                  style: const TextStyle(
                    color: Color(0xffFE4600),
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    border: InputBorder.none,
                    focusColor: const Color(0xffFE4600),
                    hintStyle: const TextStyle(color: Color(0xffFE4600)),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    hintText: label,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
