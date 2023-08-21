import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather/model/Weather_hourly.dart';
import 'package:weather/model/Weather_model.dart';
import 'package:weather/model/Weather_seven_day.dart';

class WeatherFutureApiClient {
  Future<List> fetchFutureWeatherData(String? location) async {
    var endpoint = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=065c9f80eb094111a01211802222405&q=$location&days=7&aqi=yes&alerts=no");
    var resposne = await http.get(endpoint);

    if (resposne.statusCode == 200) {
      var res = json.decode(resposne.body);
      List<SevenDayWeather> sevenDayWeather = [];

      for (var i = 0; i < 3; i++) {
        var temp = res["forecast"]["forecastday"][i];
        
        var hourly = SevenDayWeather(
          date: temp["date"],
          maxTemp: temp["day"]["maxtemp_c"],
          minTemp: temp["day"]["mintemp_c"],
          iconSevenDay: temp["day"]["condition"]["icon"].toString().substring(20),
        );
        sevenDayWeather.add(hourly);
      }

      return [sevenDayWeather];
    }
    return [null];
  }
}
