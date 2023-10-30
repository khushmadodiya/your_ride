class PredictPlaces {
  String? place_id;
  String? main_text;
  String? secondery_text;
  PredictPlaces({
    this.place_id,
    this.main_text,
    this.secondery_text,

});
  PredictPlaces.fromJson(Map<String , dynamic>jsonData){
    place_id= jsonData["place_id"];
    main_text = jsonData["structured_formatting"]["main_text"];
    secondery_text=jsonData["structured_formatting"]["secondary_text"];
  }
}