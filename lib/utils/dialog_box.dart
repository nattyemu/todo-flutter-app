import "package:flutter/material.dart";
import "package:todo_app/utils/my_buttons.dart";

class DialogBox extends StatelessWidget {
  const DialogBox({
    super.key,
    required this.controler,
    required this.onCancel,
    required this.onSave,
    required this.isCompleted,
    required this.onCompletedChanged,
    this.isEdit = false,
    this.index,
  });
  final TextEditingController controler;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final bool isEdit;
  final int? index;
  final bool isCompleted;
  final Function(bool?) onCompletedChanged;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isEdit ? "Edit Task" : "New Task",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF8C42),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: controler,
              decoration: InputDecoration(
                hintText: isEdit ? "Edit your task" : "Add a new task",
                hintStyle: TextStyle(color: Colors.grey.shade400),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            if (isEdit) ...[
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: isCompleted,
                      onChanged: onCompletedChanged,
                      activeColor: Color(0xFFFF8C42),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    Text(
                      "Mark as completed",
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: MyButton(
                    text: "Cancel",
                    onPressed: onCancel,
                    isPrimary: false,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: MyButton(
                    text: "Save",
                    onPressed: onSave,
                    isPrimary: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
