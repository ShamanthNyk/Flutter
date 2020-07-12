import 'package:http/http.dart' as http;
import 'dart:convert';
class NetworkHelper{
  final String url;
  NetworkHelper(this.url);

  Future getdata() async{
    http.Response response= await http.get(url);

    if(response.statusCode==200) {
      String data = response.body;
      print(data);
      var decodeddata = jsonDecode(data);
      return decodeddata;
    }
    else{
      print(response.statusCode);
    }

  }
}