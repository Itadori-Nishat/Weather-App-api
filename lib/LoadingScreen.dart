import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'WeatherHomePage.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          duration: 1000,
          splash: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 10),
                child: Icon(Icons.sunny,size: 35,color: Colors.yellow.shade800,),
              ),
              Text("Weather",style: GoogleFonts.dmSans(textStyle: TextStyle(
                fontSize: 30 ,
                color: Colors.black,
              ))),
            ],
          ),
          animationDuration: Duration(seconds: 1),
          splashTransition: SplashTransition.fadeTransition,
          nextScreen: MyHomePage()),
    );
  }
}