import 'package:flutter/material.dart';

class LogoTitle extends StatelessWidget {
  String title;
  LogoTitle({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,style: TextStyle(color: Colors.black,fontSize: 35.0,fontWeight: FontWeight.bold),);
  }
}
