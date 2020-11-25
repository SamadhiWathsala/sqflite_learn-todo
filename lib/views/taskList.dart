import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/services/dbService.dart';
import 'package:todo_app/views/add_task.dart';

class MyHomePage extends StatelessWidget {

  Task _task = Task();
  DbService _dbService = DbService.instance;
  List<Task> _tasks = [];



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
      ),
      body: ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (context,index){
            return ListTile(
              title: Text(_task.taskName),
              subtitle: Text("Add by"),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTask()));
        },
      ),
    );
  }
}
