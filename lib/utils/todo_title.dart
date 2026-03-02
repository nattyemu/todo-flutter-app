import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDOTile extends StatelessWidget {
  final String taskName;
  final bool taskComplted;
  final Function(bool?)? onChanged;
  final void Function(BuildContext)? deleteTask;
  final VoidCallback? onEdit;

  const ToDOTile({
    super.key,
    required this.taskName,
    required this.taskComplted,
    required this.onChanged,
    required this.deleteTask,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTask,
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              icon: Icons.delete_outline,
              label: 'Delete',
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Checkbox(
              value: taskComplted,
              onChanged: onChanged,
              activeColor: Color(0xFFFF8C42),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            title: Text(
              taskName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                decoration: taskComplted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: taskComplted ? Colors.grey : Colors.black87,
              ),
            ),
            trailing: IconButton(
              onPressed: onEdit,
              icon: Icon(Icons.edit_outlined, color: Color(0xFFFF8C42)),
              splashRadius: 20,
            ),
          ),
        ),
      ),
    );
  }
}
