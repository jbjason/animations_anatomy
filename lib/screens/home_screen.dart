import 'package:animations_anatomy/widgets/home_widgets/screen_title.dart';
import 'package:animations_anatomy/widgets/home_widgets/trip_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/bg.png"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topLeft),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 30),
            SizedBox(height: 160, child: ScreenTitle(text: 'Ninja Trips')),
            Flexible(child: TripList())
            //Sandbox(),
          ],
        ),
      ),
    );
  }
}
