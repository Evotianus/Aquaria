import 'package:flutter/material.dart';

class BubbleTextField extends StatelessWidget {
  IconData icon;
  TextEditingController controller;
  String label;
  String? type;
  Color? color;
  Color? textIconColor;

  BubbleTextField({
    super.key,
    required this.icon,
    required this.controller,
    required this.label,
    required this.color,
    required this.textIconColor,
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
              color: textIconColor,
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
                  style: TextStyle(
                    color: textIconColor,
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    border: InputBorder.none,
                    focusColor: color,
                    hintStyle: TextStyle(color: textIconColor),
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
