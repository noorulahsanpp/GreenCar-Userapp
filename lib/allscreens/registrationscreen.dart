import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_app/allscreens/loginscreen.dart';
import 'package:user_app/allscreens/mainscreen.dart';
import 'package:user_app/allwidgets/progressdialog.dart';
import 'package:user_app/main.dart';
import 'package:user_app/models/usermodel.dart';
import 'package:user_app/pages/home/widget/homepagesam.dart';
import 'package:user_app/util/configmaps.dart';
import 'package:user_app/util/firebaseutil.dart';
import 'package:user_app/util/util.dart';

UserDetails currentUser;

class RegistrationScreen extends StatelessWidget {
  static const String idScreen = "register";
  TextEditingController _nameTextEditingController = TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _phoneTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();
  DatabaseReference usersRef = FirebaseUtil.createDatabaseReference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Image(
              image: AssetImage("images/greencar.png"),
              width: 390,
              height: 250,
              alignment: Alignment.center,
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              "Register as Rider",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Brand Bold",
                  color: Color(0xff717d8c)),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: 1,
                  ),
                  TextField(
                    controller: _nameTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  TextField(
                    controller: _emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  TextField(
                    controller: _phoneTextEditingController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: "Phone",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  TextField(
                    controller: _passwordTextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_nameTextEditingController.text.isEmpty) {
                        Util.displayToastMessage(
                            "Name cannot be empty", context);
                      } else if (!_emailTextEditingController.text
                              .contains('@') ||
                          _emailTextEditingController.text.isEmpty) {
                        Util.displayToastMessage(
                            "Email Address is not valid", context);
                      } else if (_phoneTextEditingController.text.isEmpty) {
                        Util.displayToastMessage(
                            "Phone number cannot be empty", context);
                      } else if (_passwordTextEditingController.text.length <
                          7) {
                        Util.displayToastMessage(
                            "Password must be at least 6 characters", context);
                      } else {
                        registerNewUser(context);
                      }
                    },
                    color: Color(0xff3dcd84),
                    textColor: Colors.white,
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          "Create Account",
                          style:
                              TextStyle(fontSize: 18, fontFamily: "Brand Bold"),
                        ),
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24)),
                  )
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.idScreen, (route) => false);
                },
                child: Text("Already an account? Login here."))
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> registerNewUser(BuildContext context) async {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return ProgressDialog(message: "Registering, Please wait...",);
        }
    );

    final User user = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: _emailTextEditingController.text,
                password: _passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      Util.displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;
    if (user != null) {
      Map<String, String> userDataMap = {
        "name": _nameTextEditingController.text.trim(),
        "email": _emailTextEditingController.text.trim(),
        "phone": _phoneTextEditingController.text.trim(),
        "userid": user.uid,
        "rating":"0",
      };

      userRef.doc(user.uid).set(userDataMap).then((value) async {

      currentFirebaseUser = user;
      DocumentSnapshot documentSnapshot = await userRef.doc(user.uid).get();

      currentUser = UserDetails.fromDocument(documentSnapshot);

      })
          .catchError((error) => print("Failed to add user: $error"));
      usersRef.child(user.uid).set(userDataMap);
      Util.displayToastMessage(
          "Your account has been created successfully", context);
      Navigator.pushNamedAndRemoveUntil(
          context, HomePageSam.idScreen, (route) => false);
    } else {
      Navigator.pop(context);
      Util.displayToastMessage(
          "New user account has not been Created", context);
    }
  }
}
