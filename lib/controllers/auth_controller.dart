// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:get/state_manager.dart';

// class AuthController extends GetxController {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   TextEditingController nameController = TextEditingController();

//   // onChangeName() {
//   //   emailController.text;
//   //   update(['name']);
//   // }

//   // onChangeEmail() {
//   //   emailController.text;
//   //   update(['email']);
//   // }

//   // onChangePassword() {
//   //   emailController.text;
//   //   update(['pass']);
//   // }

//   Rx<User> _user = Rx<User>();

//   String get user => _user.value?.email;

//   @override
//   void onInit() {
//     nameController = TextEditingController();
//     // emailController = TextEditingController();
//     // passwordController = TextEditingController();
//     _user.bindStream(_auth.authStateChanges());
//     super.onInit();
//   }

//   @override
//   void onReady() {
//     // nameController.addListener(onChangeName);
//     // emailController.addListener(onChangeEmail);
//     // passwordController.addListener(onChangePassword);
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     nameController?.dispose();
//     // emailController?.dispose();
//     // passwordController?.dispose();
//     super.onClose();
//   }

//   void createUser(String email, String password) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       Get.snackbar(
//         'Error creating account',
//         e.code,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   login(String email, String password) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return true;
//     } on FirebaseAuthException catch (e) {
//       Get.snackbar(
//         'Error on login',
//         e.code,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return false;
//     }
//   }

//   void signOut() async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       Get.snackbar(
//         'Error SignOut',
//         e,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User> user = Rx<User>();

  get getUser => _auth.currentUser;

  String _page;

  set page(String value) {
    this._page = value;
    update();
  }

  String get page => this._page;

  @override
  void onInit() {
    user.bindStream(_auth.authStateChanges());
    this._page = (getUser != null) ? 'pruebaPage' : 'homePage';
    super.onReady();
  }

  void signOut() async {
    await _auth.signOut();
    Get.offNamed('homePage');
  }
}
