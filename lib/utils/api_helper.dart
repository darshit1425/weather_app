import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/screen/modal/weather_modal.dart';

class ApiHelper {


  Future<WeatherModel> postApiCall(String Search) async {
    String APILink = "https://api.openweathermap.org/data/2.5/weather?q=$Search&appid=1177b1e3edcc54bc767e02d9b9806249";
    Uri uri = Uri.parse(APILink);

    var resonse = await http.get(uri);
    var json = jsonDecode(resonse.body);

    WeatherModel wn=WeatherModel.fromJson(json);
    return wn;
  }
}
