import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mitch_to_do/data/database.dart';


import '../components/dialog_box.dart';
import '../components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // reference the hive box
  final _myBox = Hive.box("mybox");
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    // if this is the first time ever opening the app, then create default data
    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    }else{
      // there already exist data
      db.loadData();

    }
    super.initState();
  }
  // text controller for new task
  final _controller = TextEditingController();


  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }
  
  // save a new task
  void saveNewTask(){
    setState(() {
      db.todoList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // create a new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () {
              Navigator.of(context).pop();
            },
          );
        });
  }
  void deleteTask(int index){
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: db.todoList[index][0],
              taskCompleted: db.todoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          }),
    );
  }
}
