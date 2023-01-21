// ignore_for_file: camel_case_types, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, dead_code, unused_element, avoid_unnecessary_containers, void_checks, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:login/modules/constant/constant.dart';

class newbutton extends StatelessWidget {
  double width;
  double height;
  Function function;
  String text;
  Color color;
  Color colortext;
  Color colorRaduis;
  newbutton(
      {required this.function,
      required this.height,
      required this.text,
      required this.width,
      required this.color,
      required this.colortext,
      required this.colorRaduis});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40.0,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: colorRaduis, width: 2),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: color),
        child: MaterialButton(
          onPressed: () {
            function();
          },
          child: Text(
            text,
            style: TextStyle(color: colortext),
          ),
        ),
      ),
    );
  }
} //final Widget? suffixIcon;

class Mytextform extends StatelessWidget {
  Icon prefixe;
  final Icon? sufix;
  String lable;
  bool obscur;
  Function valedat;
  TextEditingController controllerr;
  TextInputType typ;
  Function? onchandges;
  Mytextform({
    required this.lable,
    required this.obscur,
    required this.prefixe,
    required this.valedat,
    required this.controllerr,
    required this.typ,
    this.sufix,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: TextFormField(
          keyboardType: typ,
          controller: controllerr,
          validator: (value) {
            return valedat(value);
          },
          onChanged: (value) {
            return onchandges!(value);
          },
          decoration: InputDecoration(
              prefixIcon: prefixe,
              labelText: lable,
              suffixIcon: sufix != null
                  ? Icon(
                      Icons.remove_red_eye_outlined,
                      color: purle800,
                    )
                  : null),
          obscureText: obscur,
        ),
      ),
    );
  }
}

class defaultFormField extends StatelessWidget {
  final double width, height;
  final IconData prefix;
  final TextEditingController controller;
  final String hintText;
  final Function onTap;
  final Function? onSubmit;
  final TextInputType? keyboard;
  final IconData? suffix;
  final Function? suffixPressed;
  bool? isPassword = false;
  final Function validator;

  defaultFormField(
      {required this.height,
      required this.width,
      required this.hintText,
      required this.onTap,
      required this.validator,
      required this.controller,
      required this.prefix,
      this.suffixPressed,
      this.suffix,
      this.keyboard,
      this.isPassword,
      this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: TextFormField(
          onFieldSubmitted: (val) {
            if (onSubmit != null) {
              onSubmit!(val);
            }
          },
          cursorColor: purle800,
          controller: controller,
          keyboardType: keyboard ?? TextInputType.text,
          obscureText: isPassword ?? false,
          onTap: () {
            return onTap();
          },
          validator: (value) {
            return validator(value);
          },
          decoration: InputDecoration(
            labelText: hintText,
            prefixIcon: Icon(
              prefix,
              color: purle800,
            ),
            suffixIcon: suffix != null
                ? IconButton(
                    onPressed: () {
                      return suffixPressed!();
                    },
                    icon: Icon(
                      suffix,
                      color: purle800,
                    ),
                  )
                : Container(
                    width: 10.0,
                  ),
            border: OutlineInputBorder(),
          ),
        ));
  }
}
