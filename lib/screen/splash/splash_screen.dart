import 'package:app/constant.dart';
import 'package:app/request.dart';
import 'package:app/screen/preference/preference.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;
  Map? data;

  @override
  void initState() {
    isLoading = true;
    navigateToPreference(context, 3);
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/go.png",
                scale: 0.4,
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  // Define the function that calls setState
  Future<void> navigateToPreference(BuildContext context, int duration) async {
    await Future.delayed(Duration(seconds: duration));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((context) => Preference())));
  }
}
