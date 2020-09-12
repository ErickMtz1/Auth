import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/widgets/background.dart';
import 'package:login/widgets/button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Viajes'),
      ),
      body: Stack(children: [
        Background(),
        _buttons(context),
      ]),

      //Center(
      //   child:
      // ),
    );
  }

  _buttons(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Button(
              text: 'Sign In',
              onPressed: () {
                Get.toNamed('loginPage');
              }),
          Button(
              text: 'Sign Up',
              onPressed: () {
                Get.toNamed('registerPage');
              })
        ],
      ),
    );
  }
}
