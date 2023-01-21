// ignore_for_file: must_be_immutable, deprecated_member_use, prefer_const_constructors, avoid_print, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/modules/constant/constant.dart';
import 'package:login/modules/home_screen/home_screen.dart';
import 'package:login/modules/register_screen/register_screen.dart';
import 'package:login/provider.dart';
import 'package:login/shared/components/components.dart';
import 'package:login/shared/components/custom_buttom.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';
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
                    icon: Icon(Icons.backspace),
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
              SizedBox(
                height: 17.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Log ',
                        style: TextStyle(
                          fontFamily: 'Acaslon Regular',
                          fontSize: 60,
                          fontWeight: FontWeight.w700,
                          color: purple300,
                        ),
                        children: const [
                          TextSpan(
                            text: 'In',
                            style: TextStyle(
                              color: purle800,
                              fontSize: 60,
                              fontFamily: 'Acaslon Regular',
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Icon(
                    Icons.login_outlined,
                    color: purple300,
                    size: 60.0,
                  )
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              defaultFormField(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 65.0,
                controller: emailController,
                hintText: 'Email',
                prefix: Icons.email_outlined,
                keyboard: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Correct Email";
                  }
                },
                onTap: () {
                  return 'mm';
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              defaultFormField(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 65.0,
                controller: passwordController,
                hintText: 'Password',
                onTap: () {
                  return 'mm';
                },
                prefix: Icons.password,
                isPassword: isPassword,
                suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                suffixPressed: () {
                  setState(() {
                    isPassword = !isPassword;
                  });
                },
                keyboard: TextInputType.visiblePassword,
                validator: (value) {
                  if (value.isEmpty) {
                    return value.length < 8
                        ? "Enter Password 6+ characters"
                        : null;
                  }
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 30.0,
              ),
              CustomButton(
                height: 55.0,
                width: MediaQuery.of(context).size.width * 0.8,
                buttonName: 'LOG IN',
                fontColor: white,
                buttonColor: purle800,
                function: () async {
                  errorMessage = "";
                  setState(() {});
                  if (formKey.currentState!.validate()) {
                    var url = Uri.parse('http://10.0.2.2:8000/api/login');
                    var response = await http.post(url, body: {
                      "email": emailController.text,
                      "password": passwordController.text,
                    });

                    if (response.statusCode == 200) {
                      var decodedResponse = jsonDecode(response.body);
                      context.read<MyProvider>().token =
                          decodedResponse['data'];
                      url = Uri.parse('http://10.0.2.2:8000/api/profile');
                      response = await http.get(url, headers: {
                        "Authorization": "Bearer ${decodedResponse['data']}"
                      });
                      print(response.statusCode);
                      context.read<MyProvider>().email = emailController.text;
                      context.read<MyProvider>().token =
                          decodedResponse['data'];
                      decodedResponse = jsonDecode(response.body);
                      context.read<MyProvider>().name =
                          decodedResponse['data']['name'];
                      context.read<MyProvider>().id =
                          decodedResponse['data']['id'];
                      print(context.read<MyProvider>().name);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false);
                    } else
                      setState(() {
                        errorMessage = "no such account";
                      });
                  }
                },
              ),
              SizedBox(
                height: 18.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Account ?",
                    style: TextStyle(
                      color: purle800,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Acaslon Regular',
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      color: Colors.white24,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: purple300,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
