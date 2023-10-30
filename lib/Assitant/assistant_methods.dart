import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:your_ride/Assitant/request_assistant.dart';
import 'package:your_ride/Infohandler/app_info.dart';
import 'package:your_ride/globle/globle.dart';
import 'package:your_ride/models/directions.dart';
import 'package:your_ride/models/user_model.dart';

import '../globle/map_key.dart';

class AssistantMethod{
  static void readCurrenOnlinUserInfo()async{
    currentUser = firebaseAuth.currentUser;
    DatabaseReference userRef =   FirebaseDatabase.instance.ref().child('user').child(currentUser!.uid);
    userRef.once().then((snap) {
       if(snap.snapshot.value!=null){
         userModelCurrentinfo = UserModel.fromSnapshot(snap.snapshot);
            
       }
    });

  }
  static Future<String> searchAddressForGeograficCordinates(Position position , context)async{
      String apiUrl =  "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude}, ${position.longitude}&key=$mapkey";
      String humanreadableAddrees ="";
      var requestResponse = await  RequesAssistant.reciverRequest(apiUrl);
      if(requestResponse != "Error Occured. Faild. No Response."){
        humanreadableAddrees = requestResponse["results"][0]["formatted_address"];
        Directions userPickUpAddress = Directions();
        userPickUpAddress.loactionLatitude = position.latitude;
        userPickUpAddress.loactionLongitude = position.longitude;
        userPickUpAddress.locationName = humanreadableAddrees;
        Provider.of<AppInfo>(context,listen:false).updatePickUpLocationAddress(userPickUpAddress);
      }
      return humanreadableAddrees;
  }
}