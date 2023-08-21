import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather/model/Weather_model.dart';
import 'package:weather/screen/Loading_screen.dart';
import 'package:weather/screen/Weather_details_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/service/weather_api_client.dart';
import 'package:weather/service/weather_hourly_api_client.dart';
import 'package:dots_indicator/dots_indicator.dart';

class TempratureScreen extends StatefulWidget {
  const TempratureScreen({super.key});

  @override
  State<TempratureScreen> createState() => _TempratureScreenState();
}

class _TempratureScreenState extends State<TempratureScreen> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  TextEditingController _searchController = TextEditingController();
  Future<void> getData(String location) async {
    if (location.isEmpty) {
      data = await client.getCurrentWeather("kolkata");
    }
    data = await client.getCurrentWeather(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 73, 132, 181),
      body: FutureBuilder(
        future: getData(_searchController.text),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage(""),
                  alignment: Alignment.topCenter,
                  opacity: .5,
                  fit: BoxFit.cover,
                ),
              ),
              child: Expanded(
                child: Container(
                  child: Column(children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Center(
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                "${data?.name},${data?.region}\n",
                                            style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        TextSpan(text: "${data?.dateTime}"),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SmoothPageIndicator(
                                      controller: _pageController,
                                      count: 2,
                                      axisDirection: Axis.horizontal,
                                      effect: const ExpandingDotsEffect(
                                        dotColor: Colors.black26,
                                        activeDotColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 8,
                      child: PageView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: _pageController,
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return Container(
                                child: Column(children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.search,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                getData(_searchController.text);
                                              });
                                            },
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: TextField(
                                                controller: _searchController,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  fillColor: Colors.transparent,
                                                  hintText: "Search...",
                                                  suffixIcon: IconButton(
                                                    icon: const Icon(
                                                      Icons.clear,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () =>
                                                        _searchController
                                                            .clear(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 6,
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .70,
                                                child: SvgPicture.asset(
                                                  "assets${data?.currentIcon.toString()}.svg",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                  child: Column(
                                                children: [
                                                  Container(
                                                    child: RichText(
                                                      textAlign:
                                                          TextAlign.center,
                                                      text: TextSpan(children: [
                                                        TextSpan(
                                                          text:
                                                              "${data?.condition}\n",
                                                          style: const TextStyle(
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        TextSpan(
                                                          text: " ${data?.maxTemp?.toInt()}°/" +
                                                              "${data?.minTemp?.toInt()}°",
                                                          style: const TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .55,
                                                    child: Stack(children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: RichText(
                                                          textAlign:
                                                              TextAlign.center,
                                                          text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                    text:
                                                                        "${data?.temp?.toInt()} ",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            100))
                                                              ]),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 35,
                                                          ),
                                                          child: IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                getData(
                                                                    _searchController
                                                                        .text);
                                                              });
                                                            },
                                                            icon: const Icon(
                                                              Icons
                                                                  .replay_rounded,
                                                              size: 35,
                                                              color: Colors
                                                                  .white60,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 16,
                                                          right: 10,
                                                        ),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: RichText(
                                                            textAlign: TextAlign
                                                                .center,
                                                            text:
                                                                const TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                      text:
                                                                          "°C",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              40,
                                                                          fontWeight:
                                                                              FontWeight.bold))
                                                                ]),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 25),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .30,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black12,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration:
                                                                const BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      "assets/images/AQI.png"),
                                                                  fit: BoxFit
                                                                      .contain),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 2,
                                                          ),
                                                          RichText(
                                                            textAlign: TextAlign
                                                                .center,
                                                            text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                      text:
                                                                          " AQI ${data?.aqi}",
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w500))
                                                                ]),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                            ),
                                          ],
                                        ),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  RichText(
                                                    textAlign: TextAlign.center,
                                                    text: const TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              "Develop by jeetu\n\n",
                                                          style: TextStyle(
                                                            letterSpacing: 2,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "© version 1.0.1.0",
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                ]),
                              );
                            } else {
                              return WeatherDetailsScreen(
                                temp: data?.temp,
                                humidity: data?.humidity,
                                realFeel: data?.realFeel,
                                pressure: data?.pressure,
                                visibility: data?.visibility,
                                sunrise: data?.sunrise,
                                sunset: data?.sunset,
                                windSpeed: data?.windSpeed,
                                uv: data?.uv,
                                aqi: data?.aqi,
                                windDegree: data?.windDegree,
                                windDirection: data?.windDirection,
                                location: _searchController.text,
                                dateTime: data?.dateTime,
                                isDay: data?.isDay,
                                epoch: data?.epoch,
                              );
                            }
                          }),
                    ),
                  ]),
                ),
              ),
            );
          }
          return const LoadingScreen();
        },
      ),
    );
  }

  // String? getWeatherPhoto(String icon) {
  //   if (icon == "01d") {
  //     return "assets/images/trace.svg";
  //   }
  //   if (icon == "01n") {
  //     return "assets/images/sun_at_mid.png";
  //   } else if (icon == "02d") {
  //     return "assets/images/sun_at_mid.png";
  //   } else if (icon == "02n") {
  //     return "assets/images/sun_at_mid.png";
  //   } else if (icon == "03d" || icon == "03n") {
  //     return "assets/images/sun_at_mid.png";
  //   } else if (icon == "04d" || icon == "04n") {
  //     return "assets/images/sun_at_mid.png";
  //   } else if (icon == "09d" || icon == "09n") {
  //     return "assets/images/sun_at_mid.png";
  //   } else if (icon == "10d") {
  //     return "assets/images/sun_at_mid.png";
  //   } else if (icon == "10n") {
  //     return "assets/images/sun_at_mid.png";
  //   } else if (icon == "11d" || icon == "11n") {
  //     return "assets/images/sun_at_mid.png";
  //   } else if (icon == "13d" || icon == "13n") {
  //     return "assets/images/sun_at_mid.png";
  //   } else if (icon == "50d" || icon == "50n") {
  //     return "assets/images/sun_at_mid.png";
  //   }
  //   return null;
  // }
}
