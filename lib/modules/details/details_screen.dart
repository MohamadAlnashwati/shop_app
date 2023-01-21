// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, no_logic_in_create_state, unnecessary_this, implementation_imports

import 'package:flutter/material.dart';
import 'package:login/modules/constant/constant.dart';
import 'package:login/modules/constant/http_helper.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key? key, required this.val}) : super(key: key);
  var val;
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool like = false;
  bool loading = true;
  _DetailsScreenState();
  @override
  void initState() {
    super.initState();
    HttpHelper.addView(
        productId: widget.val['id'], token: context.read<MyProvider>().token);
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(),
            backgroundColor: purle800,
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "http://10.0.2.2:8000/${widget.val["photo"]}"),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "name of the Product:  ${widget.val["name"]}",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "the Category:  ${widget.val["name"]}",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "the Price is: ${widget.val["price"]} ",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "date of End: ${widget.val["expiry_date"]}",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "number of Products: ${widget.val["quantity"]}",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "the Phone is:",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      TextButton(
                          onPressed: () {
                            launch("tel://${widget.val["social"]}");
                          },
                          child: Text(
                            "${widget.val["social"]}",
                            style: const TextStyle(color: white),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          like = await HttpHelper.getLike(
                            token: context.read<MyProvider>().token,
                            id: widget.val['id'],
                          );
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              Icon(like == false
                                  ? Icons.thumb_up_off_alt_outlined
                                  : Icons.thumb_up_rounded),
                              Text(
                                'Like',
                                style: TextStyle(
                                    color: like == false ? black : blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: const [
                              Icon(Icons.messenger),
                              Text(' Comment'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          );
  }
}
