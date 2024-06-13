

import 'package:hive/hive.dart';

class TodoDatabase {
  // list of to do tasks
  List todoList = [];

  // reference our box
  final _myBox = Hive.box("mybox");

  // run this method if this is 1st time opening this app
  void createInitialData() {
    todoList = [
      ["Demo Task 1", false],
      ["Demo Task 2", true]
    ];
  }

  // load the data from database
  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDatabase() {
    _myBox.put("TODOLIST", todoList);
  }
}
