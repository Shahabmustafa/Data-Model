import 'package:flutter/material.dart';

class StateFullwidget extends StatefulWidget {
  const StateFullwidget({Key? key}) : super(key: key);

  @override
  State<StateFullwidget> createState() => _StateFullwidgetState();
}

class _StateFullwidgetState extends State<StateFullwidget> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('App Bar')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(DateTime.now().toString()),
          Center(child: Text(count.toString(),style: TextStyle(fontSize: 40.0),)),
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
