import 'package:flutter/material.dart';

class BubbleButton extends StatelessWidget {
  String label;
  Color color;
  double length;
  Color textColor;
  TextEditingController? controller;
  String? type;
  IconData? icon;

  BubbleButton({
    super.key,
    this.controller,
    this.type,
    this.icon,
    required this.color,
    required this.label,
    required this.length,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            width: length,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                width: length,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: (type == "TextField" ? isTextField() : isButton()),
              ),
            ),
          ),
        ),
        const Positioned(
          top: 9,
          left: 14,
          child: Image(
            image: AssetImage('assets/bubble-tint.png'),
          ),
        ),
      ],
    );
  }

  Widget isTextField() {
    return TextField(
      controller: this.controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        border: InputBorder.none,
        focusColor: textColor,
        hintStyle: TextStyle(color: textColor),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        hintText: label,
      ),
      style: TextStyle(
        color: textColor,
        decoration: TextDecoration.none,
        fontSize: 16,
      ),
    );
  }

  Widget isButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      child: Row(
        children: [
          icon == null
              ? const Text('')
              : Row(
                  children: [
                    Icon(
                      icon,
                      color: textColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
