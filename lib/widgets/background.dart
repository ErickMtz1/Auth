import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        // width: double.infinity,
        // height: double.infinity,
        image: AssetImage('assets/background.png'),
        fit: BoxFit.cover,
      ),
    );
  }
}
