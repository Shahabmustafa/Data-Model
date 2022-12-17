import 'package:apps/Utls/Routes/routes_name.dart';
import 'package:apps/View/home_view.dart';
import 'package:apps/View/login_view.dart';
import 'package:apps/View/splash_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../View/signin_view.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case RoutesName.Splash:
        return MaterialPageRoute(builder: (BuildContext context) => SplashView());
      case RoutesName.LogIn:
        return MaterialPageRoute(builder: (BuildContext context) => LoginView());
      case RoutesName.SignIn:
        return MaterialPageRoute(builder: (BuildContext context) => SignInView());
      case RoutesName.Home:
        return MaterialPageRoute(builder: (BuildContext context) => HomePage());
      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('Roults not Define'),
            ),
          );
        });
    }
  }
}