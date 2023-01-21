// ignore_for_file: use_key_in_widget_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:login/modules/constant/constant.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String buttonName;
  final Function()? onTap;
  final Function() function;
  final Color buttonColor;
  final Color? fontColor;

  const CustomButton({
    required this.height,
    required this.width,
    required this.buttonName,
    this.onTap,
    required this.buttonColor,
    required this.function,
    this.fontColor,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(50),
          color: buttonColor,
        ),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                function();
              },
              child: Text(
                '$buttonName',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: fontColor ?? purle800,
                    fontFamily: 'Acaslon Regular'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
