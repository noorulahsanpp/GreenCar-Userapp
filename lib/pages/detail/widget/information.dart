import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/allscreens/registrationscreen.dart';
import 'package:user_app/allwidgets/progressdialog.dart';
import 'package:user_app/data/models/food.dart';
import 'package:user_app/global/btn_primary.dart';
import 'package:user_app/models/ridedetailsmodel.dart';
import 'package:user_app/pages/home/widget/homepagesam.dart';
import 'package:user_app/theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:user_app/util/util.dart';
import 'btn_event.dart';

class Information extends StatefulWidget {
  const Information({
    Key key,
    @required this.rideDetails,
  }) : super(key: key);

  final RideDetails rideDetails;

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {


  Future<void> requestTrip(
      BuildContext context, String tripid, String hostid) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Setting Up, Please wait...",
          );
        });

    Map<String, dynamic> tripDataMap = {
      "riderid": currentUser.userid,
      "tripid": tripid,
      "ridername": currentUser.name,
      "riderphone": currentUser.phone,
      "riderrating": currentUser.rating,
      "hostid": hostid,
    };

    FirebaseFirestore.instance
        .collection('trips')
        .doc(tripid)
        .collection('request')
        .add(tripDataMap)
        .then((value) {
      FirebaseFirestore.instance
          .collection("hosts")
          .doc(hostid)
          .collection('trips')
          .doc(tripid)
          .collection('requests')
          .add(tripDataMap);
      Util.displayToastMessage(
          "Your Request has been created successfully", context);
      Navigator.pushNamed(context, HomePageSam.idScreen);
    }).catchError((error) => print("Failed to add request: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 0.55,
      builder: (BuildContext context, ScrollController controller) {
        return Container(
          decoration: BoxDecoration(
            color: Style.blacklight,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 60.0,
                height: 5.0,
                margin: EdgeInsets.symmetric(vertical: 15.0),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: <Widget>[
                    _title(context, widget.rideDetails),
                    // _text(context),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.date_range, size: 25,color: Style.yellow,),
                              // SvgPicture.asset(
                              //   path,
                              //   width: 25.0,
                              //   color: Style.yellow,
                              // ),
                              SizedBox(height: 8.0),
                              Text(
                                widget.rideDetails.date,
                                style: Theme.of(context).textTheme.button.copyWith(
                                    color: Colors.white70, fontSize: 14.0, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          _bordeLeft(),
                          Column(
                            children: [
                              Icon(Icons.timer, size: 25,color: Style.yellow,),
                              // SvgPicture.asset(
                              //   path,
                              //   width: 25.0,
                              //   color: Style.yellow,
                              // ),
                              SizedBox(height: 8.0),
                              Text(
                                widget.rideDetails.seats,
                                style: Theme.of(context).textTheme.button.copyWith(
                                    color: Colors.white70, fontSize: 14.0, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          _bordeLeft(),
                          Column(
                            children: [
                              Icon(Icons.airline_seat_recline_extra, size: 25,color: Style.yellow,),
                              // SvgPicture.asset(
                              //   path,
                              //   width: 25.0,
                              //   color: Style.yellow,
                              // ),
                              SizedBox(height: 8.0),
                              Text(
                                widget.rideDetails.seats,
                                style: Theme.of(context).textTheme.button.copyWith(
                                    color: Colors.white70, fontSize: 14.0, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          _bordeLeft(),
                          Column(
                            children: [
                              Icon(Icons.star, size: 25,color: Style.yellow,),
                              // SvgPicture.asset(
                              //   path,
                              //   width: 25.0,
                              //   color: Style.yellow,
                              // ),
                              SizedBox(height: 8.0),
                              Text(
                                widget.rideDetails.seats,
                                style: Theme.of(context).textTheme.button.copyWith(
                                    color: Colors.white70, fontSize: 14.0, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _quantity(context, double.parse(widget.rideDetails.shareprice)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: BtnPrimary(
                        onPressed: (){
                          requestTrip(context, widget.rideDetails.tripid, widget.rideDetails.hostid);
                        },
                        text: "Request Ride",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _title(BuildContext context, RideDetails rideDetails) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${rideDetails.fromplace}",
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        Text(
          ">",
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        Text(
          "${rideDetails.toplace}",
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        // Spacer(),

      ],
    ),
  );
}

Widget _text(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Text(
      'Hi',
      textAlign: TextAlign.justify,
      style: Theme.of(context)
          .textTheme
          .caption
          .copyWith(color: Colors.white, fontSize: 15),
    ),
  );
}

Widget _additionalInformation(BuildContext context, String path, String text) {
  return Column(
    children: [
      Icon(Icons.date_range, size: 25,color: Style.yellow,),
      // SvgPicture.asset(
      //   path,
      //   width: 25.0,
      //   color: Style.yellow,
      // ),
      SizedBox(height: 8.0),
      Text(
        text,
        style: Theme.of(context).textTheme.button.copyWith(
            color: Colors.white70, fontSize: 14.0, fontWeight: FontWeight.w500),
      ),
    ],
  );
}

Widget _quantity(BuildContext context, double price) {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container(
        //   padding: EdgeInsets.all(2.0),
        //   decoration: BoxDecoration(
        //     color: Colors.black,
        //     borderRadius: BorderRadius.circular(10.0),
        //   ),
        //   child: Row(
        //     children: [
        //       // BtnEvent(
        //       //   color: Style.blacklight,
        //       //   icon: Icons.remove,
        //       //   onPressed: null,
        //       // ),
        //       // Padding(
        //       //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //       //   child: Text(
        //       //     '1',
        //       //     style: Theme.of(context).textTheme.headline6.copyWith(
        //       //           color: Colors.white,
        //       //           fontWeight: FontWeight.w800,
        //       //         ),
        //       //   ),
        //       // ),
        //       // BtnEvent(
        //       //   color: Style.blacklight,
        //       //   icon: Icons.add,
        //       //   onPressed: null,
        //       // ),
        //     ],
        //   ),
        // ),
        // Spacer(),
        Text(
          "\₹ ${price.toString()}",
          style: Theme.of(context).textTheme.headline4.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    ),
  );
}

Widget _bordeLeft() {
  return Container(
    height: 20.0,
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(
          width: 2,
          color: Colors.white24,
          style: BorderStyle.solid,
        ),
      ),
    ),
  );
}
