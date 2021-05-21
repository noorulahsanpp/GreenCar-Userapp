import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:user_app/allscreens/loginscreen.dart';
import 'package:user_app/allscreens/searchscreen.dart';
import 'package:user_app/allwidgets/divider.dart';
import 'package:user_app/assistants/requestAssistant.dart';
import 'package:user_app/datahandler/appData.dart';
import 'package:user_app/models/address.dart' as ad;

class MainScreen extends StatefulWidget {

  static const String idScreen = "mainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Position currentPosition;
  var geoLocator = Geolocator();
  String _address;
  double bottomPaddingofMap = 0;
  Address ad;

  void locatePosition()async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(target: latLngPosition, zoom:14);

    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    // _getAddress(currentPosition.latitude, currentPosition.longitude).then((value) => {
    //
    // setState(() {
    //   ad.Address as = new ad.Address(latitude: position.latitude.toString(), longitude: position.longitude.toString(), placeName: value.first.addressLine);
    //   _address = "${value.first.addressLine}";
    //
    // })
    // });
    String address = await RequestAssistant.getAddress(currentPosition.latitude, currentPosition.longitude, context);
    setState(() {
      _address = address;
    });
    // print("sadddddddddddddddddd${Provider.of<AppData>(context).pickUpLocation.placeName}");
    // await RequestAssistant.getAddress(currentPosition.latitude, currentPosition.longitude).then((value) => {
    //   setState((){
    //     print("afffffffffffffffffffffffffff${value.first.addressLine}");
    //   })
    // });

  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        color: Colors.white,
        width: 220,
        child: Drawer(
          child: ListView(
            children: [
              //Drawer header
              Container(
                height: 165,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image.asset("images/user_icon.png", height: 65,width: 65,),
                      SizedBox(width: 16,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Profile Name", style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Brand-Bold"
                          ),),
                          SizedBox(height: 6,),
                          Text("Visit Profile"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              DividerWidget(),
              SizedBox(height: 12,),

            //  Drawer Body
              ListTile(
                leading: Icon(Icons.history,
              ),
                title: Text("History", style: TextStyle(
                  fontSize: 15
                ),),
              ),
              ListTile(
                leading: Icon(Icons.person,
                ),
                title: Text("Visit Profile", style: TextStyle(
                    fontSize: 15
                ),),
              ),
              ListTile(
                leading: Icon(Icons.info,
                ),
                title: Text("About", style: TextStyle(
                    fontSize: 15
                ),),
              ),
              GestureDetector(
                onTap: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                },
                child: ListTile(
                  leading: Icon(Icons.info,
                  ),
                  title: Text("Logout", style: TextStyle(
                      fontSize: 15
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingofMap),
          mapType: MapType.normal,
          // myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller){
            _controllerGoogleMap.complete(controller);
            newGoogleMapController = controller;

            setState(() {
              bottomPaddingofMap = 280;
            });

            locatePosition();

            },
          ),

          Positioned(
            top: 45,
            left: 22,
            child: GestureDetector(
              onTap: (){
  scaffoldKey.currentState.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6,
                      spreadRadius: .5,
                      offset: Offset(
                        0.7,.7
                      )
                    )
                  ]
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.menu, color: Colors.black,),
                  radius: 20,
                ),
              ),
            ),
          ),
          Positioned(
              left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 290,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 16,
                  spreadRadius: 0.5,
                  offset: Offset(0.7,0.7),
                )
              ]
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  Text("Hi there!", style: TextStyle(fontSize: 10),),
                  Text("Where to?", style: TextStyle(fontSize: 20, fontFamily: "Brand-Bold"),),
                  SizedBox(
                    height: 6,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6,
                              spreadRadius: 0.5,
                              offset: Offset(0.7,0.7),
                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.blueAccent,),
                            SizedBox(width: 10,),
                            Text("Search Drop Off"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24,),
                  Row(
                    children: [
                      Icon(Icons.home, color: Colors.grey,),
                      SizedBox(width: 12,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Provider.of<AppData>(context, listen: false).pickUpLocation != null ? Provider.of<AppData>(context).pickUpLocation.placeName : "Add home"
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text('Your living home address', style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12
                            ),)
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  DividerWidget(),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Icon(Icons.work, color: Colors.grey,),
                      SizedBox(width: 12,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add Work"),
                            SizedBox(
                              height: 4,
                            ),
                            Text('$_address', style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12
                            ),)
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),)
        ],
      ),
    );
  }

  // Future<List<Address>> _getAddress(double lat, double lang) async {
  //   final coordinates = new Coordinates(lat, lang);
  //   List<Address> add =
  //   await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   return add;
  // }


}
