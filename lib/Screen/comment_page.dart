import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:json/Model/comments_model.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  List<Comments> commints = [];
  Future<List<Comments>> getData()async{
   var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
   if(response.statusCode == 200){
     var json = jsonDecode(response.body);
     for(var data in json){
       Comments model = Comments.fromJson(data);
       commints.add(model);
     }
   }
   return commints;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context,snappshot){
          if(snappshot.hasData){
            return Text('Add data');
          }else{
            return Center(child: const CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
