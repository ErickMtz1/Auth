import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:form_field_validator/form_field_validator.dart';

import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import 'package:login/controllers/auth_controller.dart';

class LoginController extends GetxController {
  AuthController _authController = Get.find<AuthController>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText;
  bool _isLoading;

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Please enter a valid email'),
  ]);


  @override
  void onInit() {
    _obscureText = true;
    _isLoading = false;
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _authController.user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  @override
  void onReady() {
    emailController.addListener(onChangeEmail);
    passwordController.addListener(onChangePassword);
    super.onReady();
  }

  @override
  void onClose() {
    emailController?.dispose();
    passwordController?.dispose();
    obscureText = true;
    _isLoading = false;
    super.onClose();
  }

  set obscureText(bool value) {
    this._obscureText = value;
    update(['pass']);
  }

  bool get obscureText => this._obscureText;

  set isLoading(bool value) {
    this._isLoading = value;
    update(['loading']);
  }

  bool get isLoading => this._isLoading;

  onChangeEmail() {
    emailController.text;
    update(['email']);
  }

  onChangePassword() {
    passwordController.text;
    update(['pass']);
  }

  Future<bool> login() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      return true;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error on login', e.code,
          margin: EdgeInsets.only(
              bottom: 10.0, left: Get.width * 0.30, right: Get.width * 0.30),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
          duration: Duration(seconds: 4));
      return false;
    }
  }
}
