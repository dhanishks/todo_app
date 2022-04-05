import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/db/db.dart';
import 'package:todo_application/service/service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({key}) : super(key: key);

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  List<TaskModel> tasks = [];
  List<TaskModel> list = [];
  late TaskModel currentTask;
  bool _validate = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    _nameController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Todohelper _todoHelper = Todohelper();

    void getData() async{
      List<TaskModel> list = await _todoHelper.getAllTask();
      setState(() {
        tasks = list;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white10,
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(height: 100,
                child: Center(
                  child: Text('Todo App',style: TextStyle(fontSize: 48.0),),),
              ),

              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Enter the task',
                    errorText: _validate ? 'Value Can\'t Be Empty' : null,
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 16.0,),
              TextField(
                controller: _bodyController,
                decoration: InputDecoration(
                    labelText: 'Enter the  task body',
                    errorText: _validate ? 'Value Can\'t Be Empty' : null,
                    border: OutlineInputBorder()),
              ),

              FlatButton(onPressed: (){
                setState(() {
                  _nameController.text.isEmpty ? _validate = true : _validate = false;
                });
                currentTask = TaskModel(taskTitle: _nameController.text, id: 2, taskBody: _bodyController.text, taskDate: DateTime.now().toIso8601String());
                if(_validate) return;
                else _todoHelper.insertTask(currentTask);
                _nameController.clear();
                _bodyController.clear();
                getData();
              }, child: Text('Insert'),color: Colors.red,),

              FlatButton(onPressed: () async{
                getData();
              }, child: Text('Show all'),color: Colors.blue,),

              FlatButton(onPressed: (){
                _todoHelper.deleteAllTask();
                getData();
              }, child: Text('Clear All'),color: Colors.grey,),

              Expanded(
                  child:Card(
                    elevation: 10.0,
                    child: ListView.separated(
                        itemBuilder: (context,index){
                          return ListTile(
                            tileColor: Colors.white10,
                            leading: Text("${index+1}"),
                            title: Column(children: [
                              Text("${tasks[index].taskTitle}"),
                              Text("${tasks[index].taskBody}"),
                            ],),
                            subtitle: Text("${tasks[index].taskDate}"),
                            trailing: GestureDetector(child: Icon(Icons.delete),onTap: (){
                              _todoHelper.deleteTask(tasks[index].id);
                              getData();
                            },),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: tasks.length),
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        FirebaseAuth.instance.signOut();
        setState(() {
          Email.text = '';
        });
        Navigator.pop(context);
      },child: Icon(Icons.logout),),
    );
  }
}