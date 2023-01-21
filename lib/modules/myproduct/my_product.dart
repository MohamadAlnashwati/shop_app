// ignore: file_names
// ignore_for_file: file_names, implementation_imports, duplicate_ignore, avoid_unnecessary_containers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:login/modules/constant/http_helper.dart';
import 'package:login/modules/details/details_screen.dart';
import 'package:provider/src/provider.dart';

import '../../provider.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({Key? key}) : super(key: key);

  @override
  _MyProductState createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      loaded = false;
    });
    await HttpHelper.getData(token: context.read<MyProvider>().token);
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? Scaffold(
            appBar: AppBar(
              title: const Text("My Profile"),
            ),
            body: Container(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return build_progect(
                      context.read<MyProvider>().productList[index], context);
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 5.0,
                ),
                itemCount: context.read<MyProvider>().productList.length,
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}

Widget build_progect(var val, context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsScreen(
                    val: val,
                  )));
    },
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Image(
                image: NetworkImage('http://10.0.2.2:8000/${val["photo"]}'),
                // AssetImage('assets/images/2.png'),
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    //right lift
                    vertical: 10.0,
                    horizontal: 10.0),
                width: double.infinity,
                color: Colors.black45.withOpacity(.5),
                child: Column(
                  children: [
                    Text(
                      val['name'],
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PopupMenuButton(
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: TextButton(
                                      child: const Text("Deleat"),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Are you sure !! '),
                                                actions: [
                                                  TextButton(
                                                      child: const Text("no"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      }),
                                                  TextButton(
                                                      child: const Text("yes"),
                                                      onPressed: () {
                                                        HttpHelper
                                                            .deleteProduct(
                                                          token: context
                                                              .read<
                                                                  MyProvider>()
                                                              .token,
                                                          id: val["id"],
                                                        );
                                                        Navigator.pop(context);
                                                      }),
                                                ],
                                              );
                                            });
                                      },
                                    ),
                                    value: 1,
                                  ),
                                  PopupMenuItem(
                                    child: TextButton(
                                      child: const Text("Edit"),
                                      onPressed: () {},
                                    ),
                                    value: 2,
                                  )
                                ])
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    ),
  );
}
