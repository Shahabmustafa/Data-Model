import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json/Model/model_two.dart';
import '../Model/model_three.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({Key? key}) : super(key: key);

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<Postmodel> postModel = [];
  Future<List<Postmodel>> getData()async{
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode == 200){
      var jsonParse = jsonDecode(response.body.toString());
      for(var data in jsonParse){
        Postmodel model = Postmodel.fromJson(data);
        postModel.add(model);
      }
    }
    return postModel;
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Postmodel>>(
        future: getData(),
        builder: (context,snapshpot){
          if(snapshpot.hasData){
            return ListView.builder(
              itemCount: snapshpot.data?.length,
            itemBuilder: (context,index){
                var data = snapshpot.data![index];
                  return Column(
                    children: [
                      Text(data.id.toString()),
                    ],
                  );
                });
          }else{
            return Text('error ');
          }
        },
      )
    );
  }
}
