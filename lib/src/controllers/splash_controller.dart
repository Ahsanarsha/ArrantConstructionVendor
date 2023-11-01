import 'package:arrant_construction_vendor/src/models/user.dart';
import 'package:arrant_construction_vendor/src/pages/login.dart';

import 'package:arrant_construction_vendor/src/repositories/user_repo.dart'
    as user_repo;

import 'package:get/get.dart';

class SplashController extends GetxController {
  String errorString = "Splash Controller Error :";
  Future<void> goToNextScreen() async {
    user_repo
        .getCurrentUser()
        .then((User _u) {
          if (_u.authToken != null && _u.authToken!.isNotEmpty) {
            Get.offAllNamed('/bottomNavPage/0');
          } else {
            Get.offAll(
              const LoginPage(),
              transition: Transition.rightToLeft,
            );
          }
        })
        .onError((error, stackTrace) {})
        .whenComplete(() {});
  }
}
