import 'package:arrant_construction_vendor/src/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController _con = Get.put(SplashController());

  @override
  void initState() {
    super.initState();

    _con.goToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
