import 'package:flutter/material.dart';
import 'package:todoreal/Util/MyButton.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({super.key, this.controller,required this.onCancel,required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add a New Task"
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(text:"Save", onPressed: onSave),
                  SizedBox(width: 8),
                  MyButton(text:"Cancel", onPressed: onCancel)
                ],
              )
            ],
          ),
      ),
    );
  }
}
