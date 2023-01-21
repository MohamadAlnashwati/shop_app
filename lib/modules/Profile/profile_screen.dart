import 'package:flutter/material.dart';
import 'package:login/modules/constant/constant.dart';
import 'package:login/provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 28.0,
            ),
            const CircleAvatar(
              maxRadius: 52.0,
              backgroundImage: AssetImage('assets/images/image1s.png'),
            ),
            const SizedBox(
              height: 60.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 8.0,
                ),
                const Icon(Icons.person, color: purle800),
                const SizedBox(
                  width: 10.0,
                ),
                const Text(
                  'My Name: ',
                  style: TextStyle(
                    color: purple300,
                    fontSize: 20.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Acaslon Regular',
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Text(
                  context.read<MyProvider>().name,
                  style: const TextStyle(
                    color: purle800,
                    fontSize: 25.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Acaslon Regular',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 8.0,
                ),
                const Icon(Icons.email, color: purle800),
                const SizedBox(
                  width: 10.0,
                ),
                const Text(
                  'My Email: ',
                  style: TextStyle(
                    color: purple300,
                    fontSize: 20.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Acaslon Regular',
                  ),
                ),
                Text(
                  context.read<MyProvider>().email,
                  style: const TextStyle(
                    color: purle800,
                    fontSize: 25.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Acaslon Regular',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
