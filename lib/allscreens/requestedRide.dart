import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_app/allscreens/registrationscreen.dart';
import 'package:user_app/allwidgets/progressdialog.dart';
import 'package:user_app/pages/home/widget/homepagesam.dart';
import 'package:user_app/theme/style.dart';

class RequestedRide extends StatefulWidget {
  const RequestedRide({Key key}) : super(key: key);

  @override
  _RequestedRideState createState() => _RequestedRideState();
}

class _RequestedRideState extends State<RequestedRide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("users")
              .doc(currentUser.userid)
              .collection("trips")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Error");
            }
            final list = snapshot.data.docs;
            if (list.length <= 0) {
              return Scaffold(body: Center(child: Text("No trips"),),);
            } else {
              return ListView.separated(
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) => SizedBox(
                  height: 8,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Style.blacklight, Style.blacklight])),
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      width: MediaQuery.of(context).size.width,
                      height: 160,
                      // color: Color.fromRGBO(64, 75, 96, .9),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${list[index]["from_place"].toUpperCase()}",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white54),
                                  ),
                                ),
                                Expanded(
                                    child: Icon(
                                      FontAwesomeIcons.solidCaretSquareRight,
                                      color: Colors.grey,
                                    )),
                                Expanded(
                                  child: Text(
                                    "${list[index]["to_place"].toUpperCase()}",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white54),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Date : ${list[index]["date"]}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white54),
                                ),
                              ],
                            ),
                            Center(
                              child: RaisedButton(
                                color: Colors.red.shade400,
                                onPressed: () {
                                  // cancelTrip(context, list[index].id);
                                },
                                child: Text("CANCEL RIDE"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () => {
// Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMoviePoster(imageUrl: posters[index],)))
                    },
                  ),
                ),
              );
            }
          }),
    );
  }
  Future<void> cancelTripRequest(BuildContext context, String tripid) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Cancelling, Please wait...",
          );
        });

    FirebaseFirestore.instance
        .collection('trips')
        .doc(tripid)
        .delete()
        .then((value) {
      FirebaseFirestore.instance
          .collection('hosts')
          .doc(currentUser.userid)
          .collection('trips')
          .doc(tripid)
          .delete();
      Navigator.pushNamed(context, HomePageSam.idScreen);
    });
  }
}
