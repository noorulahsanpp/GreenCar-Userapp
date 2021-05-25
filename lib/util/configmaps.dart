import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:user_app/allscreens/mainscreen.dart';
import 'package:user_app/assistants/requestAssistant.dart';
import 'package:user_app/models/ridedetailsmodel.dart';

String mapKey = "AIzaSyBr3P4Otv-N9mSbsTLnZtek1F4os-SNpRM";

User currentFirebaseUser;
