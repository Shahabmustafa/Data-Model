import 'dart:ui';
import 'package:flutter/material.dart';

class AppColor{
  static const Color BlackColor = Colors.black;
  static const Color WhiteColor = Colors.white;
  static const Color GreenColor = Colors.green;

}

class Utls{
  static void fieldFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode nextFocus){
    return FocusScope.of(context).requestFocus(nextFocus);
  }
}