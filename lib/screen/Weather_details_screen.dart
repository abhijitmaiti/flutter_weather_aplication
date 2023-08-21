import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/Weather_hourly.dart';
import 'package:weather/model/Weather_model.dart';
import 'package:weather/model/Weather_seven_day.dart';
import 'package:weather/service/weather_seven_day_api_client.dart';

import 'package:weather/service/weather_api_client.dart';
import 'package:weather/service/weather_hourly_api_client.dart';

class WeatherDetailsScreen extends StatefulWidget {
  final String? epoch;
  final double? temp;
  final int? humidity;
  final double? realFeel;
  final double? pressure;
  final double? windSpeed;
  final double? visibility;
  final String? sunrise;
  final String? sunset;
  final double? uv;
  final double? aqi;
  final int? windDegree;
  final String? windDirection;
  final String? location;
  final String? dateTime;
  final int? isDay;

  const WeatherDetailsScreen({
    super.key,
    required this.epoch,
    required this.isDay,
    required this.dateTime,
    required this.location,
    required this.temp,
    required this.humidity,
    required this.realFeel,
    required this.pressure,
    required this.windSpeed,
    required this.visibility,
    required this.sunrise,
    required this.sunset,
    required this.uv,
    required this.aqi,
    required this.windDegree,
    required this.windDirection,
  });

  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  WeatherHourlyApiClient hourlyApiClient = WeatherHourlyApiClient();
  WeatherFutureApiClient futureApiClient = WeatherFutureApiClient();
  late List<HourlyWeather> todayWeather = [];
  late List<SevenDayWeather> sevenDayWeather = [];
  Future<void> getData(String location) async {
    String loc;
    if (location.isEmpty) {
      loc = "kolkata";
    } else {
      loc = location;
    }
    hourlyApiClient.fetchHourlyWeatherData(loc).then((value) {
      todayWeather = value[0];

      setState(() {});
    });
    futureApiClient.fetchFutureWeatherData(loc).then((value) {
      sevenDayWeather = value[0];

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
          future: getData("${widget.location}"),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 15,
                      ),
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                left: 20,
                                right: 20,
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .06,
                                      decoration: BoxDecoration(
                                        color: Colors.white12,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: RichText(
                                          text: const TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "3-day forecast",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: ListView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount: sevenDayWeather.length,
                                            itemBuilder: ((context, index) {
                                              Color backgroundColor = index == 0
                                                  ? const Color.fromARGB(
                                                      72, 18, 139, 237)
                                                  : Colors.transparent;
                                              return WeatherContent(
                                                weather: sevenDayWeather[index],
                                                backgroundColor:
                                                    backgroundColor,
                                              );
                                              // return Container(
                                              //     margin: const EdgeInsets.only(
                                              //         bottom: 10),
                                              //     height: 50,
                                              //     child: Row(
                                              //       mainAxisAlignment:
                                              //           MainAxisAlignment
                                              //               .spaceBetween,
                                              //       children: [
                                              //         Row(
                                              //           children: [
                                              //             Container(
                                              //                 width: 60,
                                              //                 height: 100,
                                              //                 decoration: const BoxDecoration(
                                              //                     image: DecorationImage(
                                              //                         image: AssetImage(
                                              //                             "assets/images/sun_with_cloud.png"),
                                              //                         fit: BoxFit
                                              //                             .cover))),
                                              //             RichText(
                                              //                 text: TextSpan(
                                              //                     children: [
                                              //                   TextSpan(
                                              //                       text:
                                              //                           "yesterday",
                                              //                       style: TextStyle(
                                              //                           fontSize:
                                              //                               18))
                                              //                 ]))
                                              //           ],
                                              //         ),
                                              //         Container(
                                              //           margin: const EdgeInsets
                                              //               .only(right: 5),
                                              //           child: RichText(
                                              //               text: TextSpan(
                                              //                   children: [
                                              //                 TextSpan(
                                              //                     text: "33°",
                                              //                     style: TextStyle(
                                              //                         fontSize:
                                              //                             18)),
                                              //                 TextSpan(
                                              //                     text: "/",
                                              //                     style: TextStyle(
                                              //                         fontSize:
                                              //                             18,
                                              //                         color: Colors
                                              //                             .white30)),
                                              //                 TextSpan(
                                              //                     text: "22°",
                                              //                     style: TextStyle(
                                              //                         fontSize:
                                              //                             18))
                                              //               ])),
                                              //         )
                                              //       ],
                                              //     ));
                                            })),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20,
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        .06,
                                    decoration: BoxDecoration(
                                      color: Colors.white12,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                        child: RichText(
                                            text: const TextSpan(children: [
                                      TextSpan(
                                          text: "24-hour forecast",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ))
                                    ]))),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    child: Container(
                                      child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: todayWeather.length,
                                          itemBuilder: ((context, index) {
                                            String listTime = DateFormat.Hm()
                                                .format(DateTime.parse(
                                                    todayWeather[index]
                                                        .time
                                                        .toString()));

                                            String dt2 =
                                                widget.epoch.toString();
                                            DateTime now = DateTime.parse(dt2);
                                            String formattedDate =
                                                DateFormat.H().format(now) +
                                                    ":00";
                                            print(formattedDate);

                                            // String formattedDate =
                                            //     DateFormat.H().format(now) +
                                            //         ":00";
                                            // print(now);

                                            Color backgroundColor =
                                                formattedDate == listTime
                                                    ? const Color.fromARGB(
                                                        72, 18, 139, 237)
                                                    : Colors.white12;
                                            return TodayWeatherContent(
                                              weather: todayWeather[index],
                                              backgroundColor: backgroundColor,
                                            );
                                          })),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      height: MediaQuery.of(context).size.height * .28,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              right: 10,
                              bottom: 10,
                            ),
                            child: Container(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.black26,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 13),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: getDirection(
                                                              widget
                                                                  .windDirection
                                                                  .toString()),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      16)),
                                                      TextSpan(
                                                          text:
                                                              "${widget.windSpeed}km/h",
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.white54,
                                                          ))
                                                    ])),
                                              ),
                                              Expanded(
                                                child: Center(
                                                    child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/wind_with_cloud.png"),
                                                          fit: BoxFit.contain,
                                                          opacity: .8,
                                                        )),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                            image: AssetImage(
                                                                "assets/images/wind_compass.png"),
                                                            fit: BoxFit.contain,
                                                          )),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child:
                                                            RotationTransition(
                                                          turns: AlwaysStoppedAnimation(
                                                              (widget.windDegree)! /
                                                                  360),
                                                          child: Container(
                                                            width: 50,
                                                            decoration:
                                                                const BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/images/wind_compass_nedeel.png"),
                                                              fit: BoxFit
                                                                  .contain,
                                                            )),
                                                          ),
                                                        ),
                                                      ),
                                                      const Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: CircleAvatar(
                                                            radius: 3,
                                                            backgroundColor:
                                                                Colors.red,
                                                          ))
                                                    ],
                                                  ),
                                                )),
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(
                                                      children: [
                                                        const TextSpan(
                                                            text: "Sunrise\n",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .white54,
                                                            )),
                                                        TextSpan(
                                                            text:
                                                                "${widget.sunrise}",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        15))
                                                      ],
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 5,
                                                    ),
                                                    child: Divider(
                                                      height: 2,
                                                      color: Colors.white24,
                                                    ),
                                                  ),
                                                  RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(
                                                      children: [
                                                        const TextSpan(
                                                            text: "Sunset\n",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .white54,
                                                            )),
                                                        TextSpan(
                                                            text:
                                                                "${widget.sunset}",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        15))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "${getSunAsset(widget.dateTime.toString(), widget.sunrise.toString(), widget.sunset.toString(), widget.isDay.toString()).toString()}"),
                                                  fit: BoxFit.contain)),
                                        ))
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          )),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, right: 20, left: 20),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 5,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: const TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "Humidity",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white54,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "${widget.humidity}" +
                                                        "%",
                                                    style: const TextStyle(
                                                        fontSize: 15),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        height: 2,
                                        color: Colors.white24,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, top: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: const TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: "Real feel",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white54,
                                                      ))
                                                ],
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          "${widget.realFeel?.toInt()}°",
                                                      style: const TextStyle(
                                                          fontSize: 15))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        height: 2,
                                        color: Colors.white24,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, top: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: const TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: "UV",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white54,
                                                      ))
                                                ],
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          "${widget.uv?.toInt()}",
                                                      style: const TextStyle(
                                                          fontSize: 15))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        height: 2,
                                        color: Colors.white24,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, top: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: const TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: "Pressure",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white54,
                                                      ))
                                                ],
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          "${widget.pressure?.toInt()}",
                                                      style: const TextStyle(
                                                          fontSize: 15)),
                                                  const TextSpan(
                                                      text: "mbar",
                                                      style: TextStyle(
                                                          fontSize: 10)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        height: 2,
                                        color: Colors.white24,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: const TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: "visibility",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white54,
                                                      ))
                                                ],
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          "${widget.visibility?.toInt()}km",
                                                      style: const TextStyle(
                                                          fontSize: 15))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        height: 2,
                                        color: Colors.white24,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 15,
                                width: 30,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/AQI.png"),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "AQI ${widget.aqi}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ]))
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 15),
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Air Quality Index",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white54,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(children: [
                              TextSpan(
                                  text: "Data provide by",
                                  style: TextStyle(color: Colors.white60))
                            ]),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/weatherapilogo.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  String? getSunAsset(
      String dateTime, String sunRiseTime, String sunSetTime, String isDay) {
    DateTime tempDateTime = DateFormat.H().parse(dateTime);
    DateTime tempSunriseTime = DateFormat.H().parse(sunRiseTime);
    DateTime tempSetTime = DateFormat.H().parse(sunSetTime);

    if (tempDateTime == tempSunriseTime) {
      return "assets/images/sunrise.png";
    } else if (tempDateTime == tempSetTime) {
      return "assets/images/sunset.png";
    } else if (isDay == "1") {
      return "assets/images/sun_at_mid.png";
    } else if (isDay == "0") {
      return "assets/images/moon.png";
    }
    return "";
  }

  String getDirection(String text) {
    if (text == "N") {
      return "North\n";
    } else if (text == "NE" || text == "NNE" || text == "ENE") {
      return "Northeast\n";
    } else if (text == "SE" || text == "ESE" || text == "SSE") {
      return "Southeast\n";
    } else if (text == "S") {
      return "South\n";
    } else if (text == "SW" || text == "SSW" || text == "WSW") {
      return "Southwest\n";
    } else if (text == "W") {
      return "West\n";
    } else {
      return "Northwest\n";
    }
  }
}

class WeatherContent extends StatelessWidget {
  final SevenDayWeather weather;
  final Color backgroundColor;
  const WeatherContent({
    Key? key,
    required this.weather,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.only(bottom: 10),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets${weather.iconSevenDay.toString()}.svg",
                  fit: BoxFit.contain,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: getDateText("${weather.date}"),
                      style: const TextStyle(fontSize: 18))
                ]))
              ],
            ),
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "${weather.maxTemp?.toInt()}°",
                    style: const TextStyle(fontSize: 18)),
                const TextSpan(
                    text: "/",
                    style: TextStyle(fontSize: 18, color: Colors.white30)),
                TextSpan(
                    text: "${weather.minTemp?.toInt()}°",
                    style: const TextStyle(fontSize: 18))
              ])),
            )
          ],
        ));
  }

  String getDateText(String date) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
    String day = DateFormat("EEEE")
        .format(DateTime(tempDate.year, tempDate.month, tempDate.day))
        .substring(0, 3);
    if (day == "Sun") {
      return "Sunday";
    } else if (day == "Mon") {
      return "Monday";
    } else if (day == "Tue") {
      return "Tuesday";
    } else if (day == "Wed") {
      return "Wednesday";
    } else if (day == "Sat") {
      return "Saturday";
    } else if (day == "Fri") {
      return "Friday";
    } else {
      return "Thrusday";
    }
  }
}

class TodayWeatherContent extends StatelessWidget {
  final HourlyWeather weather;
  final Color backgroundColor;
  const TodayWeatherContent({
    Key? key,
    required this.weather,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: 20,
      width: 100,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: "${weather.current?.toInt()}°",
                          style: const TextStyle(fontSize: 20),
                        )
                      ])),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: SvgPicture.asset(
                  "assets${weather.iconHourly.toString()}.svg",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(text: "${weather.windSpeedHourly}km/h")
                      ])),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: DateFormat.Hm()
                                .format(DateTime.parse("${weather.time}")),
                            style: const TextStyle(
                              color: Colors.white54,
                            ))
                      ])),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
