// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names, unnecessary_string_interpolations, prefer_typing_uninitialized_variables, avoid_print, sized_box_for_whitespace, implementation_imports

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/Drawer/drawer.dart';
import 'package:login/modules/add_screen/Add.dart';
import 'package:login/modules/constant/constant.dart';
import 'package:login/modules/constant/http_helper.dart';
import 'package:login/modules/details/details_screen.dart';
import 'package:login/modules/search/search_screen.dart';
import 'package:login/provider.dart';
import 'package:provider/src/provider.dart';

class Usermodel {
  final String name;

  Usermodel({required this.name});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Image> images = [
    Image.asset('assets/images/123.jpg'),
    Image.asset('assets/images/12345.png'),
    Image.asset('assets/images/12.jpg'),
    Image.asset('assets/images/1234.jpg'),
    Image.asset('assets/images/1234567.jpg'),
    Image.asset('assets/images/th.png'),
  ];

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    initLoading();
  }

  void initLoading() async {
    context.read<MyProvider>().productList =
        await HttpHelper.getData(token: context.read<MyProvider>().token);
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: purle800,
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Add()));
              },
            ),
            // appBar: AppBar(
            //   backgroundColor: purle800,
            //   title: Text(
            //     'SHOP',
            //     style: TextStyle(
            //         color: white,
            //         fontSize: 22.0,
            //         fontWeight: FontWeight.bold,
            //         letterSpacing: 5),
            //   ),
            // ),
            drawer: AppDrawer(),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 2.0,
                  expandedHeight: 200.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'SHOP',
                      style: TextStyle(
                          color: white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
                        color: purple300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                                children: const [
                                  TextSpan(text: "Find Your\n"),
                                  TextSpan(
                                      text: "Product",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                      )),
                                  TextSpan(text: "  Here"),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                print('Go to Search Screen');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearhScreen()));
                              },
                              child: Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: Icon(
                                        Icons.search,
                                        size: 30.0,
                                      ),
                                    ),
                                    Text(
                                      'Serach Here ... ',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 15, 15.0, 7.0),
                        child: Text(
                          "Categories",
                          style: TextStyle(
                            color: purle800,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      CarouselSlider(
                        items: images,
                        options: CarouselOptions(
                          height: 200.0,
                          initialPage: 0,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(seconds: 2),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      // Container(
                      //   height: MediaQuery.of(context).size.height * 0.5,
                      //   child: ListView.separated(
                      //     physics: BouncingScrollPhysics(),
                      //     scrollDirection: Axis.vertical,
                      //     itemBuilder: (context, index) =>
                      //     separatorBuilder: (context, index) => SizedBox(
                      //       height: 20.0,
                      //     ),
                      //     itemCount: users.length,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, var index) => build_progect(
                          context.read<MyProvider>().productList[index],
                          context),
                      childCount: context.read<MyProvider>().productList.length,
                    ),
                    itemExtent: MediaQuery.of(context).size.height * 0.34),
              ],
            ),
          )
        : Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
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
                  height: 75,
                  padding: EdgeInsets.symmetric(
                      //right lift
                      vertical: 10.0,
                      horizontal: 10.0),
                  width: double.infinity,
                  color: Colors.black45.withOpacity(.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        val['name'],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            val['view_count'].toString(),
                            style: TextStyle(color: white, fontSize: 22),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.remove_red_eye,
                            color: white,
                            size: 18,
                          ),
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
}
