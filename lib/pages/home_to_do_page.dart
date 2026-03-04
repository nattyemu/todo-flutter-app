import 'package:flutter/material.dart';
import 'package:todo_app/utils/dialog_box.dart';
import 'package:todo_app/utils/todo_title.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';

class HomeToDoPage extends StatefulWidget {
  const HomeToDoPage({super.key});

  @override
  State<HomeToDoPage> createState() => _HomeToDoPageState();
}

class _HomeToDoPageState extends State<HomeToDoPage> {
  final _controler = TextEditingController();
// Reference the Hive box
  final _myBox = Hive.box("myBox");
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    super.initState();
    if (_myBox.get("TODOLIST") == null) {
      db.creatInitialData();
    } else {
      db.loadData();
    }
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
      db.uploadData();
    });
  }

  void handleSave(bool isEdit, int? index, bool isCompleted) {
    setState(() {
      if (isEdit && index != null) {
        if (_controler.text.isEmpty) {
          db.toDoList.removeAt(index);
          db.uploadData();
          Navigator.pop(context);
          _controler.clear();
          return;
        }
        db.toDoList[index][0] = _controler.text;
        db.toDoList[index][1] = isCompleted;
      } else {
        if (_controler.text.isEmpty) {
          Navigator.pop(context);
          _controler.clear();
          return;
        }
        db.toDoList.add([_controler.text, false]);
      }
      db.uploadData();
      Navigator.pop(context);
      _controler.clear();
    });
  }

  void createNewTask(bool isEdit, int? index) {
    bool tempIsCompleted = false;

    if (isEdit && index != null) {
      _controler.text = db.toDoList[index][0];
      tempIsCompleted = db.toDoList[index][1];
    } else {
      _controler.clear();
      tempIsCompleted = false;
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return DialogBox(
              isEdit: isEdit,
              index: index,
              controler: _controler,
              isCompleted: tempIsCompleted,
              onCompletedChanged: (value) {
                setState(() {
                  tempIsCompleted = value ?? false;
                });
              },
              onCancel: () {
                Navigator.pop(context);
                _controler.clear();
              },
              onSave: () => handleSave(isEdit, index, tempIsCompleted),
            );
          },
        );
      },
    );
  }

  void deleteTaskByslide(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      db.uploadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (db.toDoList.isEmpty) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.task_alt, size: 80, color: Colors.white.withAlpha(50)),
            SizedBox(height: 16),
            Text(
              "No tasks yet!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Add a task to get started",
              style: TextStyle(fontSize: 16, color: Colors.white.withAlpha(80)),
            ),
          ],
        ),
      );
    } else {
      content = ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDOTile(
            onEdit: () => createNewTask(true, index),
            taskName: db.toDoList[index][0],
            taskComplted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTask: (p0) => deleteTaskByslide(index),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFE5B4), Color(0xFFFFB347), Color(0xFFFF8C42)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, User! 👋",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "You have ${db.toDoList.length} tasks",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: const Color(0xFFFF8C42),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(child: content),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => createNewTask(false, null),
        backgroundColor: Colors.white,
        icon: Icon(Icons.add, color: Color(0xFFFF8C42)),
        label: Text(
          "Add Task",
          style: TextStyle(
            color: Color(0xFFFF8C42),
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
