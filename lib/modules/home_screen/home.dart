// ignore_for_file: avoid_print, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:login/modules/constant/constant.dart';
import 'package:login/modules/login_screen/login_screen.dart';
import 'package:login/modules/register_screen/register_screen.dart';
import 'package:login/shared/components/custom_buttom.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen1> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Material(
            shadowColor: Colors.black,
            elevation: 10,
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(150)),
            color: purle800,
            child: Container(
              height: size.height * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Image.asset(
                      'assets/images/loginA.png',
                    ),
                    height: 170,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 25.0,
                  ),
                  CustomButton(
                    height: 55.0,
                    width: MediaQuery.of(context).size.width * 0.9,
                    buttonName: 'LOG IN',
                    fontColor: white,
                    buttonColor: purle800,
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    height: 55.0,
                    width: MediaQuery.of(context).size.width * 0.9,
                    buttonName: 'Register',
                    fontColor: white,
                    buttonColor: purle800,
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
