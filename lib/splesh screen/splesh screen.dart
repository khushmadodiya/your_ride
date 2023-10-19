import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_ride/Assitant/assistant_methods.dart';
import 'package:your_ride/globle/globle.dart';
import 'package:your_ride/screens/login%20scrren.dart';
import 'package:your_ride/screens/main%20screen.dart';

class splesh extends StatefulWidget{

  @override
  State<splesh> createState() => _spleshState();
}

class _spleshState extends State<splesh> {
  stimer()async{
    Timer(Duration(seconds: 3), () async{
    if(await firebaseAuth.currentUser != null){
      firebaseAuth.currentUser !=null ? AssistantMethod.readCurrenOnlinUserInfo() : null;
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>logIn()));
    }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    stimer();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Your Ride",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
    );
  }
}