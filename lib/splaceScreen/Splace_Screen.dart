import 'dart:async';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:weather/screen/Temprature_screen.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({super.key});

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(PageTransition(
          child: TempratureScreen(),
          type: PageTransitionType.fade,
          duration: Duration(
            milliseconds: 30,
          ))),
    );
    return Container(
      color: const Color.fromARGB(255, 73, 132, 181),
      child: Center(
          child: Column(
        children: [
          Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * .5,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/Weatherlogo.png"),
                          fit: BoxFit.cover)),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Your Weather ",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 17,
                            fontStyle: FontStyle.italic),
                      ),
                      TextSpan(
                        text: "Guide",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 85,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(bottom: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Develop by jeetu\n\n",
                          style: TextStyle(
                            letterSpacing: 2,
                          ),
                        ),
                        TextSpan(
                          text: "© version 1.0.1.0",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
