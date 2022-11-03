import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../Model/model.dart';

class ExampleTwoProvider with ChangeNotifier{
  setAutogenerated(Autogenerated value){
    autogenerated.add(value);
    notifyListeners();
  }
  List<Autogenerated> autogenerated = [];
  Future<List<Autogenerated>> getExampleTwo()async{
   var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
   print(response.body);
   if(response.statusCode == 200){
     var jsonParse = jsonDecode(response.body.toString());
     for(var data in jsonParse){
       Autogenerated model = Autogenerated.fromJson(data);
       setAutogenerated(model);
     }
   }
   return autogenerated;
  }
}