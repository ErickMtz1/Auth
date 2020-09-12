import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/controllers/auth_controller.dart';
import 'package:login/widgets/button.dart';


class PruebaPage extends StatelessWidget {

  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_authController.user.value.email}'),
      ),
      body: Center(
        child: Button(text: 'Sign Out', onPressed:() => _authController.signOut()),
     ),
   );
  }
}