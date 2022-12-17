import 'package:apps/Utls/Routes/routes_name.dart';
import 'package:apps/Widget/signin_button.dart';
import 'package:apps/Widget/login_button.dart';
import 'package:apps/Widget/logo_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../Utls/app_color.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regExp = new RegExp(p);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LogoTitle(
              title: 'Log In',
          ),
          SizedBox(
            height: height *.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    focusNode: emailFocusNode,
                    validator:(_emailController){
                      if(_emailController!.isEmpty){
                        return 'Please Enter your email ';
                      }else if(!regExp.hasMatch(_emailController)){
                        return 'Please enter your Valid Email';
                      }
                    },
                    decoration: const InputDecoration(
                        hintText: 'Email',
                        icon: Icon(Icons.alternate_email_sharp)
                    ),
                      onFieldSubmitted: (value){
                        Utls.fieldFocusChange(context,emailFocusNode,passwordFocusNode);
                    }
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ValueListenableBuilder(
                      valueListenable: _obscurePassword,
                     builder: (context,value,child){
                        return TextFormField(
                          validator: (password){
                            if(password!.length < 6){
                              return 'Please Enter Your Password min 6 Digits';
                            }else {
                              return null;
                            }
                          },

                          focusNode: passwordFocusNode,
                          controller: _passwordController,
                          obscureText: _obscurePassword.value,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            icon: Icon(Icons.password),
                            suffixIcon: InkWell(
                              onTap: (){
                                _obscurePassword.value =! _obscurePassword.value;
                              },
                              child: Icon(
                                  _obscurePassword.value ? Icons.visibility_off_outlined : Icons.visibility
                              ),
                            ),
                          ),
                        );
                     }
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height *.1,
          ),
          LoginButton(
              title: "Log In",
              onTap: ()async{
                if(_formKey.currentState!.validate()){
                  await _auth.signInWithEmailAndPassword(
                      email: _emailController.text.toString(),
                      password: _passwordController.text.toString(),
                  );
                }
                Navigator.pushNamed(context, RoutesName.Home);
              }
          ),
          SizedBox(
            height: height *.03,
          ),
          LogInSignInButton(
              title: "Don't Your Account? Sign In",
              onPress: (){
                Navigator.pushNamed(context, RoutesName.SignIn);
              }
          ),
        ],
      ),
    );
  }
}
