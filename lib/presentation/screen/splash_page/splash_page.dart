import 'dart:async';

import 'package:flutter/material.dart';
import 'package:studnets_app/presentation/screen/home_screen/homescreen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreeen()));
     });
    return  Scaffold(
      body: Center(
        child: Image.asset('assets/img/students_app_splash_scrn_image.png'),
      ),
    );
  }
}