

import 'package:flutter/cupertino.dart';

import '../models/directions.dart';

class AppInfo extends ChangeNotifier{
  Directions? userPickLocation,userDropofflocation;
  int countTotalTrios =0;
  // List<String> historyTripKeyList = [];
  // List<TripHistoryModel> allTripHistoryInformationList =[];
  void updatePickUpLocationAddress(Directions userPickUpAddres){
    userPickLocation =userPickUpAddres;
    notifyListeners();
  }
  void updateDropOffLocationAddress(Directions dropOffAddress){
    userDropofflocation =dropOffAddress;
    notifyListeners();
  }
}