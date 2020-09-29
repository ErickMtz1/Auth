import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/widgets/background.dart';
import 'package:login/widgets/button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('eDënda'),
        centerTitle: true,
      ),
      body: Stack(children: [
        Background(),
        _image(),
        _buttons(context),
      ]),

      //Center(
      //   child:
      // ),
    );
  }

  Widget _image() {
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.07),
      child: Hero(
        tag: 'logo',
        child: Image(
            image: AssetImage('assets/e-Tuux.png'),
            width: Get.width,
            height: Get.height * 0.4),
      ),
    );
  }

  _buttons(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:Get.height * 0.3),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Button(
              text: 'Ingresar',
              onPressed: () {
                Get.toNamed('loginPage');
              }),
              SizedBox(height: 20.0),
          Button(
              text: 'Registrarse',
              onPressed: () {
                Get.toNamed('registerPage');
              })
        ],
      ),
    );
  }
}
