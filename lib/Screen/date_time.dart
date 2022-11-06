import 'dart:async';

import 'package:flutter/material.dart';

class DateTime extends StatefulWidget {
  const DateTime({Key? key}) : super(key: key);

  @override
  State<DateTime> createState() => _DateTimeState();
}

class _DateTimeState extends State<DateTime> {
  int count = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      count++;
      // print(count);
      setState(() {

      });
    });
  }
  Widget build(BuildContext context) {
    print('Build ${count}');
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('App Bar')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(count.toString(),style: TextStyle(fontSize: 30.0),)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          count++;
          setState(() {

          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
