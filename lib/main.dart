import 'package:flutter/material.dart';
import 'package:json/Screen/comment_page.dart';
import 'package:json/Screen/todo.dart';
import 'package:json/Screen/user_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserPage(),
    );
  }
}
