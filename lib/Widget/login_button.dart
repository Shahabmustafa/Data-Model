import 'package:apps/Utls/app_color.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String title;
  VoidCallback onTap;
  LoginButton({Key? key,required this.title,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 350.0,
        height: 40.0,
        decoration: const BoxDecoration(
          color: AppColor.BlackColor,
        ),
        child: Center(child: Text(title,style: TextStyle(color: AppColor.WhiteColor),)),
      ),
    );  }
}
