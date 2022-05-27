import 'package:animations_anatomy/widgets/app_drawer.dart';
import 'package:animations_anatomy/widgets/home_widgets/screen_title.dart';
import 'package:animations_anatomy/widgets/home_widgets/trip_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          body: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/trip/bg.png"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topLeft),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                      onTap: () => _scaffoldKey.currentState!.openDrawer(),
                      child: const Icon(Icons.read_more_sharp,
                          color: Colors.white)),
                ),
                const SizedBox(
                    height: 160, child: ScreenTitle(text: 'Ninja Trips')),
                const Flexible(child: TripList())
                //Sandbox(),
              ],
            ),
          ),
          drawer: const AppDrawer()),
    );
  }
}
