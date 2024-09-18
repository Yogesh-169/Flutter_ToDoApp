import 'package:hive_flutter/adapters.dart';

class ToDoDataBase{

  List toDoList=[];

  final _mybox=Hive.box('mybox');

  void createInitialData(){
    toDoList=[
      ["Hello",true],
      ["Start",false],
    ];
  }

  void loadData(){
    toDoList=_mybox.get("TODOLIST");
  }

  void updateDataBase(){
    _mybox.put("TODOLIST", toDoList);
  }
}