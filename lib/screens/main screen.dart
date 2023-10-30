import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:your_ride/Assitant/assistant_methods.dart';
import 'package:your_ride/Themes/thems.dart';
import 'package:your_ride/globle/globle.dart';
import 'package:your_ride/globle/map_key.dart';
import 'package:your_ride/screens/login%20scrren.dart';
import 'package:location/location.dart 'as loc;
import 'package:your_ride/screens/search_places_screen.dart';

import '../Infohandler/app_info.dart';
import '../models/directions.dart';

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
  LatLng? pickloaction;
  loc.Location location = loc.Location();
  String? _address;
  final Completer<GoogleMapController> _controllergooglmap =
  Completer<GoogleMapController>();

  CameraPosition _kGooglePlex = CameraPosition(
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


  locateUserPosition()async{
    Position cPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    userCurrentPosition =cPosition;
    LatLng latLngPosition = LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);

    CameraPosition cameraPosition = CameraPosition(target: latLngPosition,zoom: 15);
    newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    String humanreadableAddress =await AssistantMethod.searchAddressForGeograficCordinates(userCurrentPosition!, context);
    print("this is our Address "+ humanreadableAddress);
    username = userModelCurrentinfo!.name!;
    userEmail = userModelCurrentinfo!.email!;
    // intilializeGeofireListener();
    // AssistantMethod.readTripKeyforOnlineUser(context);

  }
  getAddressFromLatLng()async{
    try{
      GeoData data = await Geocoder2.getDataFromCoordinates(
          latitude:pickloaction!.latitude , longitude: pickloaction!.longitude, googleMapApiKey: mapkey);
      setState(() {
        Directions userPickUpAddress = Directions();
        userPickUpAddress.loactionLatitude = pickloaction?.latitude;
        userPickUpAddress.loactionLongitude = pickloaction?.longitude;
        userPickUpAddress.locationName = data.address;
        Provider.of<AppInfo> (context,listen: false).updatePickUpLocationAddress(userPickUpAddress);
        print(_address);
      });
    }
    catch(e){
      print("khush");
    }
  }
  checkIfLocationPermissionAllowed() async{
    _loactionPermission = await Geolocator.requestPermission();
    if(_loactionPermission == LocationPermission.denied){
      _loactionPermission= await Geolocator.requestPermission();
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIfLocationPermissionAllowed();
  }
  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
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
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                markers: markerSet,
                polylines: polylineset,
                circles: circleSet,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller){
                  // _controllerGoolgleMap.complete(controller);
                  newGoogleMapController = controller;
                  setState(() {

                  });
                  locateUserPosition();
                },
                onCameraMove: (CameraPosition? position){
                  if(pickloaction!=position!.target){
                    setState(() {
                      pickloaction = position.target;
                    });
                  }
                },
                onCameraIdle: (){
                  getAddressFromLatLng();
                },
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: Icon(Icons.location_on,size: 30,color: Colors.deepPurple,),
                ),

              ),
              // Positioned(
              //
              //     top: 40,
              //     right: 20,
              //     left: 20,
              //     child: Container(
              //       decoration: BoxDecoration(
              //         border: Border.all(color: Colors.black),
              //         color: Colors.black54,
              //
              //       ),
              //       padding: EdgeInsets.all(20),
              //       child: Text(
              //         Provider.of<AppInfo>(context).userPickLocation!=null ?
              //         (Provider.of<AppInfo>(context).userPickLocation!.locationName!).substring(0,24)+"..."
              //         : "Not Getting Address",
              //         // _address ??"this is our address",
              //         overflow: TextOverflow.visible,softWrap: true,
              //       ),
              //
              //     ))
              Positioned(
                bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20,50,20,20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: darkTheme ? Colors.black :Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: darkTheme ? Colors.grey.shade900 : Colors.grey,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_on_outlined,color: darkTheme ? Colors.amber.shade400 : Colors.blue,),
                                          SizedBox(width: 10,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Form",
                                              style: TextStyle(color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              ),
                                              Text(
                                                  Provider.of<AppInfo>(context).userPickLocation!=null ?
                                                        (Provider.of<AppInfo>(context).userPickLocation!.locationName!).substring(0,24)+"..."
                                                        : "Not Getting Address",
                                                style: TextStyle(color: Colors.grey,fontSize: 14),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 2,
                                      color: darkTheme ? Colors.amber.shade400: Colors.blue,
                                    ),
                                    SizedBox(height: 5,),
                                    Padding(padding: EdgeInsets.all(5),
                                      child:  GestureDetector(
                                        onTap: ()async{
                                          var responsefromsearchScreen = await Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPlacesScreen()));
                                          if(responsefromsearchScreen == "obtainedDropOff"){
                                            setState(() {
                                              opennavigationdrawer = false;
                                            });
                                          }
                                        },

                                        child:  Row(
                                          children: [
                                            Icon(Icons.location_on_outlined,color: darkTheme ? Colors.amber.shade400 : Colors.blue,),
                                            SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("From",
                                                  style: TextStyle(color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  Provider.of<AppInfo>(context).userDropofflocation!=null ?
                                                  Provider.of<AppInfo>(context).userDropofflocation!.locationName!
                                                      : "where to",
                                                  style: TextStyle(color: Colors.grey,fontSize: 14),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),

                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              )
              
            ],
          ),
        ),
      ),
    );
  }
}