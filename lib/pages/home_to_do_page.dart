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

  void handleSave() {
    setState(() {
      db.toDoList.add([_controler.text, false]);
      db.uploadData();
      Navigator.pop(context);
      _controler.clear();
    });
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controler: _controler,
          onCancel: () => Navigator.pop(context),
          onSave: handleSave,
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
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 0,
        title: Center(child: Text("TO DO")),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDOTile(
            taskName: db.toDoList[index][0],
            taskComplted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTask: (p0) => deleteTaskByslide(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
