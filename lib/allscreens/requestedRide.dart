import 'package:flutter/material.dart';

class RequestedRide extends StatefulWidget {
  const RequestedRide({Key key}) : super(key: key);

  @override
  _RequestedRideState createState() => _RequestedRideState();
}

class _RequestedRideState extends State<RequestedRide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Requested Rides"),
      ),
    );
  }
}
