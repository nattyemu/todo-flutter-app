import "package:flutter/material.dart";
import "package:todo_app/utils/my_buttons.dart";

class DialogBox extends StatelessWidget {
  const DialogBox({
    super.key,
    required this.controler,
    required this.onCancel,
    required this.onSave,
  });
  final TextEditingController controler;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: SizedBox(
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controler,
              decoration: InputDecoration(
                hintText: "add to do list",
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              children: [
                MyButton(text: "Save", onPressed: onSave),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: MyButton(text: "Cancle", onPressed: onCancel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
