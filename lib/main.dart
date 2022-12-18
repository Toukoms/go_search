import 'package:app/constant.dart';
import 'package:app/screen/home/home_sreen.dart';
import 'package:app/screen/preference/preference.dart';
import 'package:app/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: primaryColor),
      home: SplashScreen(),
    );
  }
}
