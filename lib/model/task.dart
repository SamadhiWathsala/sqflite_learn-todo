class Task{

          static const tblTask = 'tasks';
          static const colId = 'id';
          static const colTask = 'taskName';
          static const colAddBy = 'addBy';


  Task({this.id,this.taskName,this.addBy});

  int id;
  String taskName;
  String addBy;

  Map<String,dynamic> toMap(){
    var map = <String, dynamic>{
      colTask : taskName,
      colAddBy : addBy,
    };
    if(id != null) map[colId];
    return map;

  }

  Task.fromMap(Map<String,dynamic> map){
    id = map[colId];
    taskName = map[colTask];
    addBy = map[colAddBy];
  }

}