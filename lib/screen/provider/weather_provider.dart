import 'package:flutter/cupertino.dart';
import 'package:weather_app/screen/modal/weather_modal.dart';
import 'package:weather_app/utils/api_helper.dart';

class Weather_Provider extends ChangeNotifier{

  String search = "Surat";

  void ChangeValue(String searcData)
  {
    search = searcData;
    getData();
    notifyListeners();
  }
  Future<WeatherModel> getData() async {
    ApiHelper apiHelper = ApiHelper();

  print("============= $search");
    WeatherModel weatherModel = await apiHelper.postApiCall("$search");
    notifyListeners();

    return weatherModel;
  }
}