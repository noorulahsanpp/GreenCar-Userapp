import 'package:cloud_firestore/cloud_firestore.dart';

class RideDetails {
  final String tripid;
  final String fromplace;
  final String toplace;
  final String date;
  final String seats;
  final String shareprice;
  final String hostid;

  RideDetails({
      this.tripid,
      this.fromplace,
      this.toplace,
      this.date,
      this.seats,
      this.shareprice,
      this.hostid});

  factory RideDetails.fromDocument(DocumentSnapshot doc){
    return RideDetails(
      fromplace:doc['from_place'],
      toplace:doc['to_place'],
      date:doc['date'],
      seats:doc['seats'],
      shareprice: doc['shareprice'],
      hostid: doc['host'],
      tripid: doc['tripid'],
    );
  }
}