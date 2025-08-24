import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  final _myBox = Hive.box("myBox");
  List toDoList = [];
  void creatInitialData() {
    toDoList = [
      ["make tutorial", true],
      ["wash", false]
    ];
  }

  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  void uploadData() {
    _myBox.put("TODOLIST", toDoList);
  }
}
