import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/Provider/counter_provider.dart';
import 'package:state_management/Provider/slider_provider.dart';
import 'package:state_management/Screen%20Provider/counter_example.dart';
import 'package:state_management/Screen/home_screen.dart';
import 'package:state_management/Screen/state_full_widget.dart';
import 'package:state_management/Screen/date_time.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CounterProvider()),
          ChangeNotifierProvider(create: (_) => SliderProvider()),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CounterExample(),
      ),
    );
    
  }
}