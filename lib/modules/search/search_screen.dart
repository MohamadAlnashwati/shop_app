// ignore_for_file: avoid_unnecessary_containers, implementation_imports

import 'package:flutter/material.dart';
import 'package:login/modules/constant/constant.dart';
import 'package:login/modules/constant/http_helper.dart';
import 'package:login/modules/details/details_screen.dart';
import 'package:login/shared/components/components.dart';
import 'package:provider/src/provider.dart';

import '../../provider.dart';

class SearhScreen extends StatefulWidget {
  const SearhScreen({Key? key}) : super(key: key);

  @override
  State<SearhScreen> createState() => _SearhScreenState();
}

class _SearhScreenState extends State<SearhScreen> {
  List<bool> isSelected = [true, false, false];
  final searchController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            defaultFormField(
              width: MediaQuery.of(context).size.width,
              height: 65.0,
              controller: searchController,
              hintText: 'Search',
              prefix: Icons.search_outlined,
              keyboard: TextInputType.text,
              onSubmit: (value) async {
                if (isSelected[0] == true) {
                  context.read<MyProvider>().searchListName =
                      await HttpHelper.getSearchName(
                    name: value,
                    token: context.read<MyProvider>().token,
                  );
                } else if (isSelected[1] == true) {
                  context
                      .read<MyProvider>()
                      .updateSerchListItem(await HttpHelper.getSearchExpiryEnd(
                        expiryEnd: value,
                        token: context.read<MyProvider>().token,
                      ));
                }

                setState(() {});
              },
              validator: (value) {
                if (value.isEmpty) {
                  return "search  must be not Embty";
                }
              },
              onTap: () {},
            ),
            const SizedBox(
              height: 15.0,
            ),
            ToggleButtons(
              renderBorder: false,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('name',
                      style: TextStyle(
                        fontSize: 20.0,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('expiryEnd',
                      style: TextStyle(
                        fontSize: 20.0,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('Catogiry',
                      style: TextStyle(
                        fontSize: 20.0,
                      )),
                ),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < isSelected.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      isSelected[buttonIndex] = true;
                    } else if (buttonIndex == 1) {
                      isSelected[buttonIndex] = false;
                    } else {
                      isSelected[buttonIndex] = false;
                    }
                  }
                });
              },
              isSelected: isSelected,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return MaterialButton(
                    onPressed: () {
                      // context.read<MyProvider>().searchListName = [];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                    val: context
                                        .watch<MyProvider>()
                                        .searchListName,
                                  )));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/55.png'),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          context.read<MyProvider>().searchListName[index]
                              ['name'],
                          style: const TextStyle(
                            color: purle800,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ]),
                    ),
                  );
                },
                itemCount: context.watch<MyProvider>().searchListName.length,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
