import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/user_model.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<User> users = [];
  Future<List<User>> getData()async{
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode == 200){
      var json = jsonDecode(response.body.toString());
      for(var data in json){
        User model = User.fromJson(data);
        users.add(model);
      }
    }
    return users;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: getData(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
                itemBuilder:(context,index){
                var data = snapshot.data![index];
                return Card(
                  child: Column(
                    children: [
                      Text('Id',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(data.id.toString()),
                      Text('Name',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(data.name.toString()),
                      Text('Phone',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(data.phone.toString()),
                      Text('Address',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                      Text('Street',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(data.address!.street.toString()),
                      Text('City',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(data.address!.city.toString()),
                      Text('Geo',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(data.address!.geo!.lat.toString()),
                      Text(data.address!.geo!.lng.toString()),
                      Text('Suite',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(data.address!.suite.toString()),
                      Text('Zipcode',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(data.address!.zipcode.toString()),
                      Text('Website',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(data.website.toString()),
                      Text('Company',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                      Text('Comany Name',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(data.company!.name.toString()),
                      Text('Comany Bs',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(data.company!.bs.toString()),
                      Text('Comany Catch Phrase',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(data.company!.catchPhrase.toString()),
                    ],
                  ),
                );
                });
          }if(snapshot.hasError){
            return Text('Has Error');
          } else if(snapshot.connectionState == ConnectionState){
            return Center(child: CircularProgressIndicator());
          }else{
            return Text('Data not Add');
          }
        },
      ),
    );
  }
}
