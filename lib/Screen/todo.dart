import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/model_todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}
class _TodoPageState extends State<TodoPage> {
  Future<List<Todo>> getData()async{
    List<Todo> todo = [];
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    if(response.statusCode == 200){
      var json = jsonDecode(response.body.toString());
      for(var data in json){
        Todo model = Todo.fromJson(data);
        todo.add(model);
      }
    }
    return todo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Todo>>(
          future: getData(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState){
              return Center(child: CircularProgressIndicator());
            }else if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                  itemBuilder: (context,index){
                  var data = snapshot.data![index];
                  return Column(
                    children: [
                      Text(data.id.toString()),
                      Text(data.userId.toString()),
                      Text(data.title.toString()),
                      Text(data.completed.toString()),
                    ],
                  );
                  });
            }else{
              return Text('Error');
            }
          }
      ),
    );
  }
}
