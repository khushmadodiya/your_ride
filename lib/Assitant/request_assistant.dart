import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
class RequesAssistant{
  static Future<dynamic> reciverRequest(String url) async{
    http.Response httpResponse = await http.get(Uri.parse(url));
    try{
      if(httpResponse.statusCode ==200){
        String responseData = httpResponse.body;
        var decodeREsponse = jsonDecode(responseData);
        return decodeREsponse;
      }
      else{
        return "Error Occured . Faild . No Response";
      }
    }
    catch(exp){
      return "Error Occured . Faild . No Response";
    }
  }
}