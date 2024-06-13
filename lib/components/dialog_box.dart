import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mitch_to_do/components/mybutton.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({super.key,required this.controller,required this.onSave,required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Add a new task",
                border: OutlineInputBorder(),
              ),
            ),
            // buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(buttonName: "Save", onPressed: onSave),
                SizedBox(width: 5,),
                MyButton(buttonName: "Cancel", onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
