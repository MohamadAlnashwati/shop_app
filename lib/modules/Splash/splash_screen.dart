// ignore_for_file: sized_box_for_whitespace

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:login/modules/constant/constant.dart';
import 'package:login/modules/home_screen/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen1()),
            (route) => false));
  }

  final spinkit = const SpinKitPumpingHeart(
    color: Colors.white70,
    size: 100.0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: purle800,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.white70,
                    radius: 50.0,
                    child: Icon(
                      Icons.shop_2,
                      size: 48.0,
                      color: purle800,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'S H O P',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  spinkit,
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: const Text(
                      ' WELCOME ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
