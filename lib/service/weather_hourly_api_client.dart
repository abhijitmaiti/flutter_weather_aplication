import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather/model/Weather_hourly.dart';
import 'package:weather/model/Weather_model.dart';

class WeatherHourlyApiClient {
  Future<List> fetchHourlyWeatherData(String? location) async {
    var endpoint = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=065c9f80eb094111a01211802222405&q=$location&days=1&aqi=yes&alerts=yes");
    var resposne = await http.get(endpoint);

    if (resposne.statusCode == 200) {
      var res = json.decode(resposne.body);
      List<HourlyWeather> todayWeather = [];

      for (var i = 0; i < 24; i++) {
        var temp = res["forecast"]["forecastday"][0]["hour"];
        var hourly = HourlyWeather(
          current: temp[i]["temp_c"],
          time: temp[i]["time"],
          iconHourly: temp[i]["condition"]["icon"].toString().substring(20),
          windSpeedHourly: temp[i]["wind_kph"],
        );
        todayWeather.add(hourly);
      }

      return [todayWeather];
    }
    return [null];
  }
}
