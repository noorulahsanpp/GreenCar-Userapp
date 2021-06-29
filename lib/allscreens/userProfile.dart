import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_app/allscreens/registrationscreen.dart';
import 'package:user_app/util/util.dart';

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
  TextEditingController _nameTextEditingController = TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _phoneTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
  TextEditingController();
  TextEditingController _oldPasswordTextEditingController =
  TextEditingController();
  TextEditingController _newPasswordTextEditingController =
  TextEditingController();
  TextEditingController _confirmNewPasswordTextEditingController =
  TextEditingController();
bool textFieldEnabler = false;
bool saveprofileenabler = false;

  @override
  void initState() {
    // TODO: implement initState
    _nameTextEditingController = TextEditingController(text: name);
    _emailTextEditingController = TextEditingController(text: email);
    _phoneTextEditingController = TextEditingController(text: phone);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 50),
                ),
              ),
              currentUser.rating == 5
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    )
                  : currentUser.rating == 4
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                          ],
                        )
                      : currentUser.rating == 3
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                              ],
                            )
                          : currentUser.rating == 2
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                  ],
                                )
                              : currentUser.rating == 1
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                      ],
                                    )
                                  : null,
            ],
          ),
          color: Colors.blue,
        ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              TextField(
                enabled: textFieldEnabler,
                controller: _nameTextEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
              ),
              TextField(
                enabled: textFieldEnabler,
                controller: _emailTextEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
              ),
              TextField(
                enabled: textFieldEnabler,
                controller: _phoneTextEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Phone",
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
              ),
            ],
          ),
        ),
        saveprofileenabler == false ?
        RaisedButton(
          color: Colors.blue,
          child: Text("Edit Profile"),
          onPressed: () {
           setState(() {
             textFieldEnabler = true;
             saveprofileenabler = true;
           });
          },
        ) :
        RaisedButton(
          color: Colors.green,
          child: Text("Save Profile"),
          onPressed: () {
            setState(() {
              textFieldEnabler = false;
              saveprofileenabler= false;
            });
          },
        ),
        RaisedButton(
          child: Text("Change Password"),
          onPressed: (){_displayDialog(context);
          },
        ),
        RaisedButton(
          child: Text("Logout"),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.idScreen, (route) => false);
          },
        ),
      ],
    );
  }
  Future saveProfileDetails() async{

    User firebaseuser = await FirebaseAuth.instance.currentUser;

    Map<String, dynamic> userDataMap = {
      "name": _nameTextEditingController.text.trim(),
      "email": _emailTextEditingController.text.trim(),
      "phone": _phoneTextEditingController.text.trim(),
    };
    firebaseuser.updateEmail(_emailTextEditingController.toString()).then((value) {
      firebaseuser.reauthenticateWithCredential(EmailAuthProvider.credential(email: _emailTextEditingController.text, password: _passwordTextEditingController.text));
      FirebaseFirestore.instance.collection("hosts").doc(currentUser.userid).update(userDataMap).then((value) {
        Util.displayToastMessage("Changes applied", context);
      });
    });

  }
  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Password'),
            content: Container(
              height: 220,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: _oldPasswordTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Old Password",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                  ),
                  TextField(
                    controller: _newPasswordTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "New Password",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                  ),
                  TextField(
                    controller: _confirmNewPasswordTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      GestureDetector(child: Text("Forgot Password"),
                        // onTap: forgotPassword,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new GestureDetector(child: Text('Update Password', style: TextStyle(fontSize: 18),),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
  Future changePassword() {
    if (_newPasswordTextEditingController.text ==
        _confirmNewPasswordTextEditingController.text) {
      try {
        FirebaseAuth.instance.currentUser
            .reauthenticateWithCredential(EmailAuthProvider.credential(
            email: currentUser.email,
            password: _oldPasswordTextEditingController.text))
            .then((value) {
          FirebaseAuth.instance.currentUser
              .updatePassword(_newPasswordTextEditingController.text);
          Util.displayToastMessage("Password successfully updated", context);
          Navigator.pop(context);
        });
      } catch (error) {
        Util.displayToastMessage(error, context);
      }
    } else {
      Util.displayToastMessage("Password Does not match", context);
    }
  }

  Future forgotPassword() {
    FirebaseAuth.instance.sendPasswordResetEmail(email: currentUser.email);
    Util.displayToastMessage(
        "Password reset link has been sent to your mail", context);
    FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
