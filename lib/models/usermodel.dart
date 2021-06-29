import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails{
  String userid;
  String name;
  String email;
  String phone;
  String location;
  int rating;
  int noofrating;
  UserDetails({this.userid, this.name, this.email, this.phone, this.location, this.rating, this.noofrating});

  factory UserDetails.fromDocument(DocumentSnapshot doc){
    return UserDetails(
      userid:doc['userid'],
      name:doc['name'],
      email:doc['email'],
      phone:doc['phone'],
      rating: doc['rating'],
        noofrating: doc['noofrating'],
    );
  }
}