import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_app/allscreens/registrationscreen.dart';

import 'loginscreen.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  String name = currentUser.name;
  String phone = currentUser.phone;
  String email = currentUser.email;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(name),
          Text(email),
          Text(phone),
          RaisedButton(
            child: Text("Logout"),
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
