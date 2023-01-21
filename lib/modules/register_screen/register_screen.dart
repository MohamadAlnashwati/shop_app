// ignore_for_file: deprecated_member_use, sized_box_for_whitespace, avoid_print, implementation_imports

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/modules/constant/constant.dart';
import 'package:login/modules/home_screen/home_screen.dart';
import 'package:login/modules/login_screen/login_screen.dart';
import 'package:login/provider.dart';
import 'package:login/shared/components/components.dart';
import 'package:login/shared/components/custom_buttom.dart';

import 'package:http/http.dart' as http;
import 'package:provider/src/provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  bool isPassword = true;
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.backspace),
                    color: Colors.white,
                  ),
                  ClipPath(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      color: purle800,
                    ),
                    clipper: MyClipper(),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: const TextSpan(
                          text: 'Re',
                          style: TextStyle(
                            fontFamily: 'Acaslon Regular',
                            fontSize: 60,
                            fontWeight: FontWeight.w700,
                            color: purle800,
                          ),
                          children: [
                            TextSpan(
                              text: 'Gis',
                              style: TextStyle(
                                color: purple300,
                                fontSize: 60,
                                fontFamily: 'Acaslon Regular',
                              ),
                            ),
                            TextSpan(
                              text: 'Ter',
                              style: TextStyle(
                                color: purle800,
                                fontSize: 60,
                                fontFamily: 'Acaslon Regular',
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.app_registration_rounded,
                      color: purple300,
                      size: 60.0,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              defaultFormField(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 60.0,
                controller: fullnameController,
                hintText: 'Full Name',
                prefix: Icons.person_rounded,
                onTap: () {
                  return 'mm';
                },
                keyboard: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty || value.length < 4) {
                    return "enter valid full name";
                  }
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              defaultFormField(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 60.0,
                controller: emailController,
                hintText: 'Email',
                prefix: Icons.email_outlined,
                onTap: () {
                  return 'mm';
                },
                keyboard: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || value.length < 10) {
                    return "Enter valid email";
                  }
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              defaultFormField(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 60.0,
                controller: passwordController,
                hintText: 'Password',
                prefix: Icons.password_outlined,
                isPassword: isPassword,
                suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                suffixPressed: () {
                  setState(() {
                    isPassword = !isPassword;
                  });
                },
                onTap: () {
                  return 'mm';
                },
                keyboard: TextInputType.visiblePassword,
                validator: (value) {
                  if (value.isEmpty || value.length < 8) {
                    return "enter valid password";
                  }
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              defaultFormField(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 60.0,
                controller: confirmpasswordController,
                hintText: 'Confirm Password',
                prefix: Icons.password,
                isPassword: isPassword,
                suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                suffixPressed: () {
                  setState(() {
                    isPassword = !isPassword;
                  });
                },
                onTap: () {
                  return 'mm';
                },
                keyboard: TextInputType.visiblePassword,
                validator: (value) {
                  if (value.isEmpty || value != passwordController.text) {
                    return "both password must be equal";
                  }
                },
              ),
              const SizedBox(
                height: 28.0,
              ),
              CustomButton(
                height: 55.0,
                width: MediaQuery.of(context).size.width * 0.8,
                buttonName: 'Register',
                fontColor: white,
                buttonColor: purle800,
                function: () async {
                  if (formKey.currentState!.validate()) {
                    var url = Uri.parse('http://10.0.2.2:8000/api/register');
                    var response = await http.post(url, body: {
                      "name": fullnameController.text,
                      "email": emailController.text,
                      "password": passwordController.text,
                      "c_password": confirmpasswordController.text
                    });

                    print(response.statusCode);
                    if (response.statusCode == 200) {
                      var decodedResponse = jsonDecode(response.body);
                      context.read<MyProvider>().name = fullnameController.text;

                      context.read<MyProvider>().email = emailController.text;
                      url = Uri.parse('http://10.0.2.2:8000/api/login');
                      response = await http.post(url, body: {
                        "email": emailController.text,
                        "password": passwordController.text,
                      });
                      decodedResponse = jsonDecode(response.body);

                      context.read<MyProvider>().token =
                          decodedResponse['data'];
                      print(decodedResponse['data']);

                      url = Uri.parse('http://10.0.2.2:8000/api/profile');
                      response = await http.get(url, headers: {
                        "Authorization": "Bearer ${decodedResponse['data']}"
                      });
                      decodedResponse = jsonDecode(response.body);
                      context.read<MyProvider>().id =
                          decodedResponse['data']['id'];
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                          (route) => false);
                    }
                  }
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Alreafy have an Account ?",
                    style: TextStyle(
                      color: purle800,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Acaslon Regular',
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    color: Colors.white24,
                    child: const Text(
                      "Log in",
                      style: TextStyle(
                        color: purple300,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.75);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(55.0, 15.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
