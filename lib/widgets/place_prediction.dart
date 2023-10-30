
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_ride/Assitant/request_assistant.dart';
import 'package:your_ride/Infohandler/app_info.dart';
import 'package:your_ride/globle/globle.dart';
import 'package:your_ride/models/directions.dart';
import 'package:your_ride/models/predict_place.dart';
import 'package:your_ride/widgets/progress_dialog.dart';

class PlacePredictiontileDesign extends StatefulWidget {
  final PredictPlaces? predictPlaces;

  PlacePredictiontileDesign({this.predictPlaces});

  @override
  State<PlacePredictiontileDesign> createState() => _PlacePredictiontileDesignState();
}

class _PlacePredictiontileDesignState extends State<PlacePredictiontileDesign> {
  getPlacedirectiondetails(String? placeId ,context)async{
    showDialog(
        context: context,
        builder:(BuildContext context)=> ProgressDialog(
          message: "Setting up drop-off . Please wait",
        ),
    );
    String placeDirectiondetailUrl = "https://maps.googleapis.con/maps/pai/place/details/json?place_id=$placeId";
    var responseApi = await RequesAssistant.reciverRequest(placeDirectiondetailUrl);
    Navigator.pop(context);
    if(responseApi=="Error Occured . Faild . No Response"){
      return;
    }
    if(responseApi["status"=="OK"]){
      Directions directions =Directions();
      directions.locationName = responseApi["result"]['name'];
      directions.loactionId = placeId;
      directions.loactionLatitude = responseApi["result"]["geometry"]["location"]["lat"];
      directions.loactionLongitude = responseApi["result"]["geometry"]["location"]["lng"];
      Provider.of<AppInfo>(context,listen: false).updateDropOffLocationAddress(directions);
      setState(() {
        userDropOffAddress = directions.locationName!;
      });
      Navigator.pop(context,"ontainedDropoff");

    }

  }
  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return ElevatedButton(
        onPressed: (){
       getPlacedirectiondetails(widget.predictPlaces!.place_id!, context);
    },
        style: ElevatedButton.styleFrom(
          primary: darkTheme ? Colors.black : Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.add_location,
                color: darkTheme ? Colors.amber.shade400 : Colors.blue,
              ),
              SizedBox(width: 10,),
              Expanded(
                  child: Column(
                    children: [
                      Text(
                        widget.predictPlaces!.main_text!,
                      )
                    ],
                  )

              )
            ],
          ),
        )
    );
  }
}
