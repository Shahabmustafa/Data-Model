import 'dart:io';

import 'package:apps/Utls/app_color.dart';
import 'package:apps/View/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String? currentUserName;
String? currentUserImage;
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _imagePicker = ImagePicker();
  File? file;
  final firebase_cloud = FirebaseFirestore.instance.collection('user').get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      currentUserName = doc['Name'];
      currentUserImage = doc['ImageUrl'];
    });
  });

  getImageCamera()async{
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      file = File(image!.path);
    });
  }

  getImageGallery()async{
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
      ),
      backgroundColor: Colors.white60,
      body: Column(
        children: [
          // TODO: PostImage
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
            child: Container(
              height: 100.0,
              width: double.infinity,
              color: AppColor.WhiteColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${currentUserImage.toString()}'),
                      radius: 25,
                    ),
                    Flexible(
                      child: Container(
                        height: 40.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                        child: InkWell(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton.icon(
                                          onPressed: (){
                                            getImageCamera();
                                          },
                                          icon: (Icon(Icons.camera_alt,)),
                                          label: Text('Camera',style: TextStyle(color: AppColor.BlackColor),),
                                        ),
                                        TextButton.icon(
                                          onPressed: (){
                                            getImageGallery();
                                          },
                                          icon: (Icon(Icons.photo,color: AppColor.GreenColor,)
                                          ),
                                          label: Text('Gallery',style: TextStyle(color: AppColor.BlackColor),),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Center(
                            child: Text("What's on your mind, ${currentUserName.toString()}",
                      ),
                          ),
                        ),
                    ),
                    ),
                    IconButton(
                        onPressed: (){
                          getImageGallery();
                        },
                        icon: Icon(Icons.photo,),
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // TODO: Post Coding
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  width: double.infinity,
                  height: 500.0,
                  color: AppColor.WhiteColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5 ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage('${currentUserImage.toString()}'),
                              radius: 25.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            InkWell(
                              onTap: (){
                                
                              },
                                child: Text('${currentUserName.toString()}',style: TextStyle(fontWeight: FontWeight.bold),)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
