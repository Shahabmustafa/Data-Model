import 'package:flutter/material.dart';
import 'package:json/Model/model.dart';
import 'package:json/Screen/example_three.dart';
import 'package:json/Screen/home.dart';
import 'package:provider/provider.dart';

import 'Provider/example_two_provider.dart';
import 'Screen/example_two.dart';

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
        home: ExampleThree(),
    );
  }
}
