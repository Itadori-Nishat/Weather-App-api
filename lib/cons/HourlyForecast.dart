import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HourlyForcecastText extends StatelessWidget {
  String child;
  String child2;
  HourlyForcecastText({super.key,required this.child2, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(
            child,
            style: GoogleFonts.noticiaText(
                textStyle: const TextStyle(
                  fontSize: 17,
                )),
            textAlign: TextAlign.center,
          ),
          Text(
            child2,
            style: GoogleFonts.noticiaText(
                textStyle: const TextStyle(
                  fontSize: 17,
                )),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}



class HourlyForcecastIcon extends StatelessWidget {
  final IconData icon;
  String child;
  HourlyForcecastIcon({super.key,required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Icon(icon,size: 27,),
          Text(
            child,
            style: GoogleFonts.noticiaText(
                textStyle: const TextStyle(
                  fontSize: 17,
                )),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}