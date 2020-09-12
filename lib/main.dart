import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:login/controllers/auth_controller.dart';

import 'package:login/routes/routes.dart';

String defaultPage = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final auth = Get.put<AuthController>(AuthController());
  defaultPage = auth.page;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      debugShowCheckedModeBanner: false,
      getPages: Routes.route,
      initialRoute: defaultPage,
    );
  }
}
