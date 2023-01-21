import 'package:flutter/material.dart';
import 'package:login/provider.dart';
import 'modules/Splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<MyProvider>(
    child: const MyApp(),
    create: (context) => MyProvider(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
