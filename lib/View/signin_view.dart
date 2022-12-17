import 'dart:io';
import 'package:apps/Utls/Routes/routes_name.dart';
import 'package:apps/View/home_view.dart';
import 'package:apps/View/login_view.dart';
import 'package:apps/Widget/login_button.dart';
import 'package:apps/Widget/logo_title.dart';
import 'package:apps/Widget/signin_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Utls/app_color.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final cloud_store = FirebaseFirestore.instance.collection('user');
  final ImagePicker image = ImagePicker();
  File? file;
  String Url = "";

  Future UploadFile()async{
    String name = DateTime.now().microsecondsSinceEpoch.toString();
    var imageFile = FirebaseStorage.instance.ref().child(name).child('jpeg');
    UploadTask task = imageFile.putFile(file!);
    TaskSnapshot snapshot = await task;
    Url = await snapshot.ref.getDownloadURL();
    print(Url);
  }

  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  getImage()async{
    var img = await image.pickImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }


  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regExp = new RegExp(p);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: height*.1,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LogoTitle(
                  title: 'Sign In'
              ),
              SizedBox(
                height: height*.08,
              ),
              InkWell(
                onTap: (){
                  getImage();
                },
                child: CircleAvatar(
                     radius: 50.0,
                     backgroundImage: file == null ? NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNaXcBuk_V9sQ_yY6xHL4R-HbqblttyiLx-A&usqp=CAU') : FileImage(File(file!.path)) as ImageProvider,
                   ),
              ),
              SizedBox(
                height: height*.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onFieldSubmitted: (value){
                          Utls.fieldFocusChange(context, nameFocusNode, phoneFocusNode);
                        },
                        focusNode: nameFocusNode,
                        controller: _nameController,
                        decoration: const InputDecoration(
                            hintText: 'Name',
                            icon: Icon(Icons.person)
                        ),
                        validator: (_nameController){
                          if(_nameController!.isEmpty){
                            return 'Enter your Name';
                          }else{
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        onFieldSubmitted: (value){
                          Utls.fieldFocusChange(context, phoneFocusNode, emailFocusNode);
                        },
                        focusNode: phoneFocusNode,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
                          icon: Icon(Icons.phone),
                        ),
                        validator: (_phoneController){
                          if(_phoneController!.isEmpty){
                            return 'Enter your Phone Number';
                          }else{
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        focusNode: emailFocusNode,
                        onFieldSubmitted: (value){
                          Utls.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                        },
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
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ValueListenableBuilder(
                          valueListenable: _obscurePassword,
                          builder: (context,value,child){
                            return TextFormField(
                              focusNode: passwordFocusNode,
                              validator: (password){
                                if(password!.length < 6){
                                  return 'Please Enter Your Password min 6 Digits';
                                }else if(password.isEmpty){
                                  return 'Enter your Password';
                                }else{
                                  return null;
                                }
                              },
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
                                    _obscurePassword.value ? Icons.visibility_off_outlined : Icons.visibility,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height*.05,
              ),
              LoginButton(
                  title: 'Sign In',
                  onTap: ()async{
                    if(_formKey.currentState!.validate()){
                      await UploadFile();
                      _auth.createUserWithEmailAndPassword(
                          email: _emailController.text.toString(),
                          password: _passwordController.text.toString(),
                      );
                      cloud_store.add({
                        'Name': _nameController.text.toString(),
                        'Phone': _phoneController.text.toString(),
                        'ImageUrl': Url,
                      });
                    }
                  }
              ),
              LogInSignInButton(
                  title: "You Account has Create LogIn", onPress: (){
                    Navigator.pushNamed(context, RoutesName.LogIn);
              }
              ),
            ],
          ),
        ],
      ),
    );
  }
}