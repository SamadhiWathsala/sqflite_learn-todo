import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/services/dbService.dart';

class AddTask extends StatefulWidget {

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DbService _dbService;

  Task _task = Task();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      _dbService = DbService.instance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new task"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Task"),
                  onSaved: (val) => setState(()=>_task.taskName = val),
                  validator: (val) => (val.length == 0) ? "This field is required" : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Add By"),
                  onSaved: (val) => setState(()=>_task.addBy = val),
                  validator: (val) => (val.length == 0) ? "This field is required" : null,
                ),
              ),
              FlatButton(
                color: Colors.green,
                  onPressed: () => _onSubmit(),
                  child: Text("ADD",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
              )
            ],
          ),
        ),
      ),
    );
  }

  _onSubmit()async{
    var form = _formKey.currentState;
    if(form.validate()){
      print(_task.taskName);
      form.save();
      await _dbService.insertTask(_task);
      form.reset();
      //                   Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTask()));
    }
  }


}


