import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:user_app/allscreens/registrationscreen.dart';
import 'package:user_app/assistants/requestAssistant.dart';
import 'package:user_app/datahandler/appData.dart';
import 'package:user_app/global/title_page.dart';
import 'package:user_app/main.dart';
import 'package:user_app/models/ridedetailsmodel.dart';
import 'package:user_app/models/usermodel.dart';
import 'package:user_app/pages/home/widget/SearchTo.dart';
import 'package:user_app/pages/home/widget/header.dart';
import 'package:user_app/pages/home/widget/navigation_bar.dart';
import 'package:user_app/pages/home/widget/offers.dart';
import 'package:user_app/pages/home/widget/recommends.dart';
import 'package:user_app/pages/home/widget/search.dart';
import 'package:user_app/pages/home/widget/search_button.dart';
import 'package:user_app/pages/home/widget/select_category.dart';
import 'package:flutter/material.dart';
var list;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Position currentPosition;
  var geoLocator = Geolocator();
  String _address;
  double bottomPaddingofMap = 0;
  // Address ad;


  Future<List<RideDetails>> getdatatolist() async{

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("trips").get();

    return list = querySnapshot.docs.map((e) => RideDetails.fromDocument(e)).toList();
    // list = querySnapshot.
    // list = querySnapshot.docs.map<RideDetails>((doc) => doc.data()).toList();
    // print("ssfgssfsfafsfsfsfsfsfsfsdfsdf${list.runtimeType}");
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    String address = await RequestAssistant.getAddress(
        currentPosition.latitude, currentPosition.longitude, context);
    setState(() {
      _address = address;
    });
  }
  getUserData() {
    User user = FirebaseAuth.instance.currentUser;
    userRef.doc(user.uid).get().then((value) {
      setState(() {
        currentUser = UserDetails.fromDocument(value);
      });
    });
  }
  @override
  void initState() {
    getUserData();
    print("ssssssssssssssaaaaaaaaaa${getdatatolist()}");
    locatePosition();
    // TODO: implement initState
    super.initState();
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  Header(),
                  Search(),
                  SeachTo(),
                  SearchButton(),
                  TitlePage(title: "Starting Today"),
                  Recommends(),
                  TitlePage(title: "From ${Provider.of<AppData>(context)
                      .pickUpLocation
                      .placeName}"),
                  Offers(),
                  SliverToBoxAdapter(child: const SizedBox(height: 60)),
                ],
              ),
            ),
            // NavigationBar(),
          ],
        ),
      ),
    );
  }
}



