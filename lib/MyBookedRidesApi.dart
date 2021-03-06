import 'package:nber_flutter/MyRideModels.dart';

import 'NetworkUtil.dart';

class MyBookRidesApi{

  NetworkUtil _netUtil = new NetworkUtil();

  Future<MyRideModels> search(String userid,String token
      ) {
    // ignore: non_constant_identifier_names
    String base_token_url = NetworkUtil.base_url + 'get-ride';
    return _netUtil.post(base_token_url, body: {
      "user_id":userid,

    },headers:{"Authorization":token}, ).then((dynamic res) {
      MyRideModels results = new MyRideModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}