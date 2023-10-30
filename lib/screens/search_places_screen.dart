import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_ride/Assitant/request_assistant.dart';
import 'package:your_ride/globle/map_key.dart';
import 'package:your_ride/models/predict_place.dart';
import 'package:your_ride/widgets/place_prediction.dart';

class SearchPlacesScreen extends StatefulWidget {

  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {

  List<PredictPlaces> placePredicteList =[];
  findPlaceAutoCompleteSearch(String inputText)async{
   if(inputText.length >1){
     String urlAutocompleteSearch = "https://maps.googleapis.con/maps/pai/place/details/json?inputText=$inputText&key=$mapkey&components=country:80";
     var responseAutotoCompleteSearch = await RequesAssistant.reciverRequest(urlAutocompleteSearch);
     if(responseAutotoCompleteSearch == "Error Occured . Faild . No Response"){
       return;
     }
     if(responseAutotoCompleteSearch["status"]==["OK"]){
       var placePredictions = responseAutotoCompleteSearch["prediction"];
       var placePredictionList = (placePredictions as List).map((jsonData) => PredictPlaces.fromJson(jsonData)).toList();
       setState(() {
         placePredicteList = placePredicteList;
       });
     }
   }
  }


  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: darkTheme ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: darkTheme ? Colors.amber.shade400 : Colors.blue,
          leading: GestureDetector(
            onTap: (){
             Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: darkTheme?Colors.black: Colors.white,),

          ),
          title: Text(
            "Search & set dropoff Locacation",
            style: TextStyle(color: darkTheme ? Colors.black : Colors.white),

          ),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white54,
                    blurRadius: 8,
                    spreadRadius: 0.5,
                    offset: Offset(
                      0.7,0.7,
                    )
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.adjust_sharp,
                        color: darkTheme ? Colors.black : Colors.white,
                        ),
                        SizedBox(height: 18,),
                        Expanded(child: Padding(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            // onChanged: (value){
                              // findPlaceAutoCompleteSearch(value){
                              // }
                              decoration: InputDecoration(
                              hintText: "Search location here..",
                              fillColor: darkTheme ? Colors.black : Colors.white54,
                              filled: true,
                              border: InputBorder.none,
                              contentPadding:  EdgeInsets.only(
                                left: 11,
                                top : 8,
                                bottom: 8,
                              )

                            ),

                          ),
                        )
                       )
                      ],
                    )
                  ],
                ),
              ),
            ),
                    (placePredicteList.length > 0)
                        ? Expanded(child: ListView.separated(
                             itemBuilder: (context,index){
                                 return PlacePredictiontileDesign(
                                   predictPlaces: placePredicteList[index],
                                 ) ;
                               },
                               separatorBuilder:(BuildContext context , int index){
                               return Divider(
                                 height: 0,
                                 color: darkTheme? Colors.amber.shade400:Colors.blue,
                                 thickness: 0,
                               );
                               },
                               itemCount:  placePredicteList.length,
                               physics: ClampingScrollPhysics(),
                               )
                    ): Container(

                    ),

          ],
        ),
      ),
    );
  }
  }
