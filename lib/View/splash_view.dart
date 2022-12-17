import 'dart:async';

import 'package:apps/Utls/Routes/routes.dart';
import 'package:apps/Utls/Routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

final _auth = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(_auth != null){
      Timer(Duration(seconds:5),() => Navigator.pushNamed(context, RoutesName.Home));
    }else{
      Timer(Duration(seconds:5),() => Navigator.pushNamed(context, RoutesName.LogIn));
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text('Splash Screen')),
        ],
      ),
    );
  }
}
