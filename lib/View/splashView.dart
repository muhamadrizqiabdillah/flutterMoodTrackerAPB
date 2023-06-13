import 'dart:async';


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/globalColors.dart';
import 'loginView.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(LoginView());
    });
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: const Center(
        child: Text(
          'LOGO',
          style: TextStyle(
              color: Colors.green, fontSize: 35, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
