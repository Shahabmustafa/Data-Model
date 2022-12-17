import 'package:apps/Utls/Routes/routes_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


String? currentUserName;
String? currentUserImage;
class Navbar extends StatefulWidget {
  Navbar({Key? key}) : super(key: key);


  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  final _auth = FirebaseAuth.instance.currentUser;
  final firebase_cloud = FirebaseFirestore.instance.collection('user').get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      currentUserName = doc['Name'];
      currentUserImage = doc['ImageUrl'];
    });
    });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('${currentUserName.toString()}'),
              accountEmail: Text('${_auth!.email}'),
            currentAccountPicture:  CircleAvatar(
              backgroundImage: NetworkImage('${currentUserImage.toString()}'),
              radius: 20,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: (){
              Navigator.pushNamed(context, RoutesName.Home);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign Out'),
            onTap: ()async{
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, RoutesName.LogIn);
            },
          ),
        ],
      ),
    );
  }
}
