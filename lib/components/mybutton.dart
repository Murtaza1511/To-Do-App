import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonName;
  VoidCallback onPressed;

  MyButton({super.key, required this.buttonName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).primaryColorLight,
      onPressed: onPressed,
      child: Text(buttonName),
    );
  }
}
