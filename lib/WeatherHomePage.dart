import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'cons/HourlyForecast.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDarkMode = Get.isDarkMode;


  List<dynamic> weatherData = [];

  Future getDataFromApi() async {
    final response = await http
        .get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q"
            "=London,uk&APPID=60253f0513f7f07c46926588959c45c6"));
    final data = jsonDecode(response.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    precacheImage(const AssetImage('Assets/bg_day.png'), context);
    precacheImage(const AssetImage('Assets/bg_night.png'), context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       ListTile(
      //         leading: Icon(Icons.home),
      //         title: Text('Home'),
      //         onTap: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => LocationAccessScreen()));
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('WEATHER APP API'),
        actions: [
          Switch(
            activeColor: Colors.red,
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
              Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: getDataFromApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            final temp = data["main"]["temp"];
            final feels_like = data["main"]["feels_like"];
            final pressure = data["main"]["pressure"];
            final humidity = data["main"]["humidity"];
            final city = data["name"];
            final country = data["sys"]["country"];
            final sunrise = data["sys"]["sunrise"];
            final sunset = data["sys"]["sunset"];
            final windSp = data["wind"]["speed"];
            final windDeg = data["wind"]["deg"];
            final lon = data["coord"]["lon"];
            final lat = data["coord"]["lat"];
            final temp_min = data["main"]["temp_min"];
            final temp_max = data["main"]["temp_max"];
            final main = data["weather"][0]["main"];

            return Stack(
              fit: StackFit.expand,
              children: [
                ///Background image for dark and light theme
                isDarkMode
                    ? Image.asset(
                        "Assets/bg_night.png",
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "Assets/bg_day.png",
                        fit: BoxFit.cover,
                      ),

                ///Rest of the app
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: height * 0.2, left: 12, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ///City
                        Text(
                          "$city",
                          style: GoogleFonts.lora(
                              textStyle: const TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w500)),
                        ),
                        ///County
                        Text(
                          "$country",
                          style: GoogleFonts.notoSans(
                              textStyle: const TextStyle(
                            fontSize: 19,
                          )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ///Temp
                        Text('$temp\u00B0C',
                            style: GoogleFonts.bitter(
                                textStyle: const TextStyle(fontSize: 32))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_queue,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "$main",
                              style: GoogleFonts.sourceSerif4(
                                  textStyle: const TextStyle(
                                fontSize: 19,
                              )),
                            ),
                          ],
                        ),
                        ///Humidity
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Text("Humidity: $humidity°C",
                              style: GoogleFonts.raleway(
                                  textStyle: const TextStyle(
                                fontSize: 22,
                              ))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Text("Sunrise: $sunrise",
                                  style: GoogleFonts.noticiaText(
                                      textStyle: const TextStyle(
                                    fontSize: 17,
                                  )),
                                  textAlign: TextAlign.center),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text("Sunset: $sunset",
                                  style: GoogleFonts.noticiaText(
                                      textStyle: const TextStyle(
                                    fontSize: 17,
                                  )),
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Latitude: $lat",
                                  style: GoogleFonts.noticiaText(
                                      textStyle: const TextStyle(
                                    fontSize: 17,
                                  )),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  "Longitude: $lon",
                                  style: GoogleFonts.noticiaText(
                                      textStyle: const TextStyle(
                                    fontSize: 17,
                                  )),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Text(
                                "Max: $temp_max \u00B0C",
                                style: GoogleFonts.noticiaText(
                                    textStyle: const TextStyle(
                                      fontSize: 17,
                                    )),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                "Min: $temp_min \u00B0C",
                                style: GoogleFonts.noticiaText(
                                    textStyle: const TextStyle(
                                  fontSize: 17,
                                )),
                                textAlign: TextAlign.center,
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          "More Details",
                          style: GoogleFonts.noticiaText(
                              textStyle: const TextStyle(
                            fontSize: 17,
                                fontWeight: FontWeight.bold
                          )),
                          textAlign: TextAlign.center,
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HourlyForcecastText(child: 'Pressure:',child2: "${pressure} atm".toString(),),
                              HourlyForcecastText(child: 'Wind:',child2: "${windSp} m/s".toString(),),
                              HourlyForcecastText(child: 'Wind Temp:',child2: "${windDeg}\u00B0C".toString(),),
                              HourlyForcecastText(child: 'Feels like:',child2: "${feels_like}\u00B0C".toString(),),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2,
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}
