import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:your_ride/globle/globle.dart';
import 'package:your_ride/screens/login%20scrren.dart';
import 'package:location/location.dart 'as loc;

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  Future<void> LogOut() async {
    try {
      await firebaseAuth.signOut();
      Fluttertoast.showToast(msg: "Successfully signed out");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>logIn()));
      // Successfully signed out
    } catch (e) {
      // Handle errors, if any
      print('Error signing out: $e');
      Fluttertoast.showToast(msg: 'Error signing out: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    LatLng? pickloaction;
    loc.Location location = loc.Location();
    String? _address;
    final Completer<GoogleMapController> _controllergooglmap =
    Completer<GoogleMapController>();

   const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );
   GlobalKey<ScaffoldState> _Scafoldstate = GlobalKey<ScaffoldState>();
   double searchLocationContainerHeight =220;
   double waitingResponsefromDriverContainrHeight = 0;
   double assignedDriverInfoContainerHeight =0;
   Position? userCurrentPosition;
   var geoloacator =Geolocator();
   LocationPermission? _loactionPermission;
   double bottompaddingofMap = 0;
   List<LatLng> plineCoordinateList =[];
   Set<Polyline> polylineset ={};
   Set<Marker> markerSet ={};
   Set<Circle> circleSet ={};
   String username ="";
   String userEmail ="";
   bool opennavigationdrawer = false;
   bool actionNearbyDriverkeyLoaded = false;
   BitmapDescriptor? activenearbyIcon;
   GoogleMapController? newGoogleMapController;


    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("khush"),
          actions: [
            IconButton(onPressed: (){
              LogOut();
            }, icon: Icon(Icons.logout_outlined))
          ],
        ),
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
                myLocationButtonEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                markers: markerSet,
                polylines: polylineset,
                circles: circleSet,
                initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller){
                // _controllerGoolgleMap.complete(controller);
                newGoogleMapController = controller;
              },
            )
          ],
        ),
      ),
    );
  }
}
