class Weather {
  String? condition;
  int? humidity;
  double? realFeel;
  double? pressure;
  double? windSpeed;
  double? visibility;
  String? sunrise;
  String? sunset;
  double? temp;
  double? maxTemp;
  double? minTemp;
  double? aqi;
  double? uv;
  String? dateTime;
  String? region;
  String? name;
  int? windDegree;
  String? windDirection;
  double? current;
  String? time;
  String? currentIcon;
  int? isDay;
  String? epoch;
  Weather({
    this.epoch,
    this.isDay,
    this.currentIcon,
    this.current,
    this.time,
    this.aqi,
    this.uv,
    this.dateTime,
    this.region,
    this.name,
    this.condition,
    this.humidity,
    this.pressure,
    this.realFeel,
    this.sunrise,
    this.sunset,
    this.visibility,
    this.windSpeed,
    this.maxTemp,
    this.minTemp,
    this.temp,
    this.windDegree,
    this.windDirection,
  });
  Weather.fromJson(Map<String, dynamic> json) {
    epoch=json["current"]["last_updated"];
    dateTime = json["location"]["localtime"];
    region = json["location"]["region"];
    name = json["location"]["name"];
    condition = json["current"]["condition"]["text"];
    humidity = json["current"]["humidity"];
    pressure = json["current"]["pressure_mb"];
    aqi = json["current"]["air_quality"]["pm2_5"];
    uv = json["current"]["uv"];
    realFeel = json["current"]["feelslike_c"];
    sunrise = json["forecast"]["forecastday"][0]["astro"]["sunrise"];
    sunset = json["forecast"]["forecastday"][0]["astro"]["sunset"];
    visibility = json["current"]["vis_km"];
    windSpeed = json["current"]["wind_kph"];
    maxTemp = json["forecast"]["forecastday"][0]["day"]["maxtemp_c"];
    minTemp = json["forecast"]["forecastday"][0]["day"]["mintemp_c"];
    temp = json["current"]["temp_c"];
    windDegree = json["current"]["wind_degree"];
    windDirection = json["current"]["wind_dir"];
    currentIcon = json["current"]["condition"]["icon"].toString().substring(20);
    isDay = json["current"]["is_day"];
  }
}
