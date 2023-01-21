// ignore_for_file: avoid_print, implementation_imports

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:login/modules/Profile/profile_screen.dart';
import 'package:login/modules/constant/constant.dart';
import 'package:login/modules/login_screen/login_screen.dart';
import 'package:login/modules/myproduct/my_Product.dart';
import 'package:provider/src/provider.dart';

import '../provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            margin: EdgeInsets.all(5),
            padding: EdgeInsetsDirectional.all(60),
            decoration: BoxDecoration(
              color: purple300,
            ),
            child: Text(
              'Welcome',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.account_circle,
              color: purle800,
              size: 25,
            ),
            title: TextButton(
              child: const Text(
                'My Profile',
                style: TextStyle(
                  color: purle800,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.account_circle,
              color: purle800,
              size: 25,
            ),
            title: TextButton(
              child: const Text(
                'My Product',
                style: TextStyle(
                  color: purle800,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyProduct()));
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: purle800,
              size: 25,
            ),
            title: TextButton(
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: purle800,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  context.read<MyProvider>().token = '';
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                }),
          ),
        ],
      ),
    );
  }
}
