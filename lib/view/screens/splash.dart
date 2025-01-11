import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper_app/view/screens/home.dart';
import 'package:wallpaper_app/view/widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Get.off(() => HomeScreen(), transition: Transition.downToUp);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/splash_animation.json"),
            CustomText(
              text: "Bring Your Screen to Life with Beautiful Wallpapers!",
              textAlign: TextAlign.center,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
    ));
  }
}
