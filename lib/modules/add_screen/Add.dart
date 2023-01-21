// ignore: file_names
// ignore_for_file: file_names, prefer_const_constructors, deprecated_member_use, duplicate_ignore, non_constant_identifier_names, avoid_print, unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:login/modules/constant/constant.dart';
import 'package:login/modules/constant/http_helper.dart';
import 'package:login/shared/components/components.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../provider.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  File? _image;
  final picker = ImagePicker();

  Future upGalleryImage(context) async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  Future upCameraImage(context) async {
    var pickedImage = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  Future<void> selectedImageSource(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(
                color: purple300,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: purle800,
                  ),
                  ListTile(
                    onTap: () {
                      upGalleryImage(context);
                    },
                    title: Text(
                      "Gallery",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(
                      Icons.account_box,
                      color: purle800,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: purle800,
                  ),
                  ListTile(
                    onTap: () {
                      upCameraImage(context);
                    },
                    title: Text(
                      "Camera",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(
                      Icons.camera,
                      color: purle800,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
    
  }

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool IsBottomSheetShow = false;

  TextEditingController NameController = TextEditingController();
  TextEditingController NameProductController = TextEditingController();
  TextEditingController DataController = TextEditingController();
  TextEditingController CategoryController = TextEditingController();
  TextEditingController PhoneNumberController = TextEditingController();
  TextEditingController QuantityController = TextEditingController();
  TextEditingController PriceController = TextEditingController();
  String dropDownListVal = 'food';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: purle800,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(
            20.0,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.grey[350],
                      height: 200,
                      width: 200,
                      child: _image == null
                          ? Center(
                              child: Text(
                                'Get to the Image',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: purle800,
                                ),
                              ),
                            )
                          : Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            selectedImageSource(context);
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            color: purle800,
                            size: 25.0,
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        DropdownButton<String>(
                          icon: Icon(
                            Icons.category,
                            color: purle800,
                          ),
                          value: dropDownListVal,
                          dropdownColor: purle800,
                          iconDisabledColor: purle800,
                          items: <String>['food', 'clothes', 'cooking', 'other']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            dropDownListVal = val!;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50.0,
                  controller: NameProductController,
                  keyboard: TextInputType.name,
                  prefix: Icons.edit,
                  onTap: () {
                    return 'mm';
                  },
                  hintText: 'Name Product',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'name must not be empty';
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50.0,
                  controller: DataController,
                  keyboard: TextInputType.datetime,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.parse("2050-01-01"),
                    ).then((value) {
                      DataController.text =
                          DateFormat("yyyy-MM-dd").format(value!);
                    });
                  },
                  hintText: 'Expiration Date',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'date must not be empty';
                    }
                  },
                  prefix: Icons.date_range,
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50.0,
                  controller: PhoneNumberController,
                  keyboard: TextInputType.number,
                  onTap: () {
                    return 'mm';
                  },
                  hintText: 'Your Number Phone',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Number must not be empty';
                    }
                  },
                  prefix: Icons.phone,
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50.0,
                  controller: QuantityController,
                  keyboard: TextInputType.number,
                  hintText: 'Number Of Products ',
                  onTap: () {
                    return 'mm';
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Quantity must not be empty';
                    }
                  },
                  prefix: Icons.production_quantity_limits,
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50.0,
                  controller: PriceController,
                  keyboard: TextInputType.number,
                  onTap: () {
                    return 'mm';
                  },
                  hintText: 'Price',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Price must not be empty';
                    }
                  },
                  prefix: Icons.monetization_on,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  color: purle800,
                  child: MaterialButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        HttpHelper.addData(
                            token: context.read<MyProvider>().token,
                            filename: _image!.path.split('/').last,
                            name: NameProductController.text,
                            data: DataController.text,
                            photo: _image!,
                            quantity: QuantityController.text,
                            price: PriceController.text,
                            number: PhoneNumberController.text);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Ok',
                      style: TextStyle(
                        color: white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Acaslon Regular',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
