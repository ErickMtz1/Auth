import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;

  const Button({
    @required this.text,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: Colors.white,
      height: 45.0,
      minWidth: Get.width / 1.5,
        child: Text(
          this?.text,
          style: GoogleFonts.exo2(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.normal),
        ),
        color: Colors.deepOrangeAccent,
        padding: EdgeInsets.all(2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        onPressed: this.onPressed);
  }
}
