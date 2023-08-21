import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/model/Weather_model.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=065c9f80eb094111a01211802222405&q=$location&days=1&aqi=yes&alerts=yes");
    var resposne = await http.get(endpoint);
    var body = jsonDecode(resposne.body);

    return Weather.fromJson(body);
  }
}
