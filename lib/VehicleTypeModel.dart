class VehicleTypeModel{

  String status;
  String message;
  String response;
  VehicleTypeData data;
  List<VehicleTypeData> notificationdata;
  String username;

  VehicleTypeModel.map(dynamic obj) {
    if (obj != null) {
      this.status = obj["Response Code"];

      this.message = obj["message"];
      notificationdata = (obj['data'] as List).map((i) => VehicleTypeData.fromJson(i)).toList();
      //   data= new Userdata.map(obj["data"]);

    }


  }




}
// ignore: non_constant_identifier_names
class VehicleTypeData{

     String id;
    String type;
    String capacity;
    double baseFare;
    double extra;
    String category;
    double userCancellationCharge;
    double driverCancellationCharge;
    double waitingCharge;
    double tollCharge;
    double surcharge;
    double tax;
    String createdAt;
    String updatedAt;
   int __v;


  /*NotificationData.map(dynamic res){
    if(res!=null){
      this.access_token=res["access_token"];
      this.user_id=res["user_id"];
      this.name=res["name"];
    }
    else{

    }
  }*/
   VehicleTypeData();

  VehicleTypeData.fromJson(Map jsonMap)
      : id = jsonMap['_id'],
        type = jsonMap['type'],
        capacity = jsonMap['capacity'],
        baseFare = jsonMap['baseFare'],
        extra = jsonMap['extra'],
        category = jsonMap['category'],
        userCancellationCharge = jsonMap['userCancellationCharge'],
        driverCancellationCharge = jsonMap['driverCancellationCharge'],
        waitingCharge = jsonMap['waitingCharge'],
        tollCharge = jsonMap['tollCharge'],
        surcharge = jsonMap['surcharge'],
        tax = jsonMap['tax'],
        createdAt = jsonMap['createdAt'],
        updatedAt = jsonMap['updatedAt'],
        __v = jsonMap['__v'];


}