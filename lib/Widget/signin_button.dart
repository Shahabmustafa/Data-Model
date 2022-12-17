import 'package:apps/Utls/app_color.dart';
import 'package:flutter/material.dart';

class LogInSignInButton extends StatelessWidget {
  String title;
  VoidCallback onPress;
  LogInSignInButton({Key? key,required this.title,required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPress,
        child: Text(title,style: TextStyle(color: AppColor.BlackColor),)
    );
  }
}
