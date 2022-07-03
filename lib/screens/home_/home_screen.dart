import 'package:animations_anatomy/widgets/app_drawer.dart';
import 'package:animations_anatomy/widgets/home_widgets/screen_title.dart';
import 'package:animations_anatomy/widgets/home_widgets/trip_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/trip/bg.png"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topLeft),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 160,
                    child: ScreenTitle(
                        text: 'Ninja Trips', scaffoldKey: _scaffoldKey)),
                const Flexible(child: TripList())
                //Sandbox(),
              ],
            ),
          ),
          drawer: const AppDrawer()),
    );
  }
}
