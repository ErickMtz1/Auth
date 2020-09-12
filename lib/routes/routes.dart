import 'package:get/get.dart';

import 'package:login/pages/home_page.dart';
import 'package:login/pages/login_page.dart';
import 'package:login/pages/prueba_page.dart';
import 'package:login/pages/register_page.dart';


class Routes {

  static final route = [
    GetPage(name: 'homePage', page: () => HomePage()),
    GetPage(name: 'loginPage', page: () => LoginPage()),
    GetPage(name: 'pruebaPage', page: () => PruebaPage()),
    GetPage(name: 'registerPage', page: () => RegisterPage()),
  ];

}