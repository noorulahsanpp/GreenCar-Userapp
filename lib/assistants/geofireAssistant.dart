import 'dart:math';

import 'package:user_app/models/nearbyAvailableHost.dart';

class GeoFireAssistant{
  static List<NearbyAvailableHost> nearbyAvailableHostList = [];

  static void removeHostFromList(String key){
    int index = nearbyAvailableHostList.indexWhere((element) => element.key == key);
    nearbyAvailableHostList.removeAt(index);
  }

  static void updateHostNearbyLocation(NearbyAvailableHost driver){
    int index = nearbyAvailableHostList.indexWhere((element) => element.key == driver.key);

    nearbyAvailableHostList[index].longitude = driver.longitude;
    nearbyAvailableHostList[index].latitude = driver.latitude;
  }


}