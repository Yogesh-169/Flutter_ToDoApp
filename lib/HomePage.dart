import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todoreal/Util/DialogBox.dart';
import 'package:todoreal/Util/ToDoTile.dart';
import 'package:todoreal/data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _myBox=Hive.box('mybox');

  final _controller =TextEditingController();
  ToDoDataBase db=ToDoDataBase();

  void initState(){

    if(_myBox.get("TODOLIST")==null){
      db.createInitialData();
    }
    else
      {
        db.loadData();
      }

    super.initState();
  }

  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  // Function to handle checkbox changes
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void CreateNewTask(){
    showDialog(
        context: context,
        builder: (context){
          return DialogBox(
            controller: _controller,
            onCancel: () => Navigator.of(context).pop(),
            onSave: saveNewTask,
          );
        }
    );

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("TO DO",style: TextStyle(
            fontSize: 24,
            fontWeight:FontWeight.bold ,

          ),)),
          backgroundColor:Colors.yellow,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed:CreateNewTask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deletefunction: (context) => deleteTask(index),
            );
          },
        ),
      ),
    );
  }
}
