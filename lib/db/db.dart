import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_application/service/service.dart';

var email = Email.text.substring(0,5);
final String tableName = email;
String cId = 'id';
String cTaskTitle = 'task_title';
String cTaskBody = 'task_body';
String cTaskDate = 'task_date';


class TaskModel{
  String taskTitle;
  int id;
  String taskBody;
  String taskDate;

  // ignore: non_constant_identifier_names
  TaskModel({required this.taskTitle, required this.id, required this.taskBody, required this.taskDate});
  Map<String,dynamic> toMap(){
    return {
      cTaskTitle : this.taskTitle,
      cTaskBody : this.taskBody,
      cTaskDate : this.taskDate,
    };
  }
}

class Todohelper{
  late Database db;

  Todohelper(){
    initDatabase();
  }

  Future<void> initDatabase() async{
    db = await openDatabase(
        join(await getDatabasesPath(),"todoDatabase.db"),
        version: 1,
        onCreate: (db,version){
          return db.execute("CREATE TABLE $tableName($cId INTEGER PRIMARY KEY AUTOINCREMENT, $cTaskTitle TEXT, $cTaskBody TEXT, $cTaskDate TEXT)");
        }
    );
  }

  Future<void> insertTask(TaskModel task) async{
    try{
      db.insert(tableName, task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }catch(_){
      print(_);
    }
  }

  Future<List<TaskModel>> getAllTask() async{
    final List<Map<String,dynamic>> tasks = await db.query(tableName);

    return List.generate(tasks.length, (index) => TaskModel(
        taskTitle : tasks[index][cTaskTitle], id: tasks[index][cId],
        taskBody: tasks[index][cTaskBody], taskDate: tasks[index][cTaskDate]
    )
    );
  }

  Future<void> deleteTask(int id) async{
    try{
      db.rawDelete('DELETE FROM $tableName WHERE id = ?', [id]);
    }catch(_){
      print(_);
    }
  }

  Future<void> deleteAllTask() async{
    try{
      db.rawDelete('DELETE FROM $tableName');
    }catch(_){
      print(_);
    }
  }

}