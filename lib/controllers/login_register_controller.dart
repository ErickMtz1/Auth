import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:form_field_validator/form_field_validator.dart';

import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import 'package:login/controllers/auth_controller.dart';

import 'package:login/models/user_data_model.dart';

class LoginRegisterController extends GetxController {
  AuthController _authController = Get.find<AuthController>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool _obscureText;
  bool _isLoading;

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Please enter a valid email'),
  ]);

   final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Name is required'),
    MinLengthValidator(2, errorText: 'Password must be at least 2 digits long'),
  ]);

   final passwordRegisterValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(6, errorText: 'Password must be at least 6 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);


  @override
  void onInit() {
    _obscureText = true;
    _isLoading = false;
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _authController.user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  @override
  void onReady() {
    nameController.addListener(onChangeName);
    emailController.addListener(onChangeEmail);
    passwordController.addListener(onChangePassword);
    super.onReady();
  }

  @override
  void onClose() {
    nameController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
    obscureText = true;
    _isLoading = false;
    super.onClose();
  }

  bool get obscureText => this._obscureText;
  bool get isLoading => this._isLoading;

  set obscureText(bool value) {
    this._obscureText = value;
    update(['pass']);
  }

  set isLoading(bool value) {
    this._isLoading = value;
    update(['loading']);
  }

  onChangeName(){
    update(['name']);
  }

  onChangeEmail() {
    // emailController.text;
    update(['email']);
  }

  onChangePassword() {
    // passwordController.text;
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

  createUser() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((result) async {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        UserModel userModel = UserModel(
          name: nameController.text,
          uuid: result.user.uid,
          registerDate: result.user.metadata.creationTime,
          app: packageInfo.appName,
        );

        _updateUserFirestore(userModel, result.user);
      });
      return true;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error creating user', e.code,
          margin: EdgeInsets.only(
              bottom: 10.0, left: Get.width * 0.30, right: Get.width * 0.30),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
          duration: Duration(seconds: 4));
      return false;
    }
  }

  void _updateUserFirestore(UserModel user, User _firebaseUser) {
    final userUpdate = _db.collection('users');
    userUpdate.doc('/${_firebaseUser.uid}').set(user.toJson());
    update();
  }
}
