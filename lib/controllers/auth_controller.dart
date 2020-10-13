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
    this._page = (getUser != null) ? 'homePage' : 'homePage';
    super.onReady();
  }

  void signOut() async {
    await _auth.signOut();
    Get.offNamed('homePage');
  }
}
