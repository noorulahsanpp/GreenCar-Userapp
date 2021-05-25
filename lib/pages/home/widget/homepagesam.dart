import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:user_app/allscreens/mainscreen.dart';
import 'package:user_app/allscreens/registrationscreen.dart';
import 'package:user_app/allscreens/requestedRide.dart';
import 'package:user_app/allscreens/userProfile.dart';
import 'package:user_app/assistants/requestAssistant.dart';
import 'package:user_app/datahandler/appData.dart';
import 'package:user_app/main.dart';
import 'package:user_app/models/ridedetailsmodel.dart';
import 'package:user_app/models/usermodel.dart';
import 'package:user_app/pages/home/home_page.dart';
import 'package:user_app/theme/style.dart';
import 'package:user_app/util/configmaps.dart';

import 'package:user_app/models/address.dart' as addr;
class HomePageSam extends StatefulWidget {
  const HomePageSam({Key key}) : super(key: key);



  static const String idScreen = "homepagesam";
  @override
  _HomePageSamState createState() => _HomePageSamState();
}

class _HomePageSamState extends State<HomePageSam> with SingleTickerProviderStateMixin{
  TabController tabController;
  int selectedIndex = 0;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Position currentPosition;
  var geoLocator = Geolocator();
  String _address;
  double bottomPaddingofMap = 0;
  // Address ad;





  @override
  void initState() {

    // TODO: implement initState
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }



  void onItemClicked(int index){
    setState(() {
      selectedIndex = index;
      tabController.index = selectedIndex;
    });
  }
  @override

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          HomePage(),
          MainScreen(),
          RequestedRide(),
          UserProfile(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60.0,
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Colors.blue,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
          child: Container(
            child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 10.0),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.black54, width: 0.0),
                insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
              ),
              //For Indicator Show and Customization
              indicatorColor: Colors.black54,
              tabs: <Widget>[

                Tab(
                  icon: Icon(
                    Icons.home,
                    size: 30.0,
                  ),
                  // text: 'Home',
                ),
                Tab(
                  icon: Icon(
                    Icons.car_rental,
                    size: 30.0,
                  ),
                  // text: 'Request',
                ),
                Tab(
                  icon: Icon(
                    Icons.star,
                    size: 30.0,
                  ),
                  // text: 'Review',
                ),
                Tab(
                  icon: Icon(
                    Icons.account_box,
                    size: 30.0,
                  ),
                  // text: 'Profile',
                ),
              ],
              controller: tabController,
            ),
          ),
        ),
      ),
    );
  }
}
