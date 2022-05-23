import 'package:animations_anatomy/models/trip.dart';
import 'package:animations_anatomy/screens/details_screen.dart';
import 'package:flutter/cupertino.dart';

class PageRouting extends PageRouteBuilder {
  final Trip widget;
  PageRouting({required this.widget})
      : super(
            transitionDuration: const Duration(seconds: 1),
            pageBuilder: (context, animation, secondAnimation) =>
                Details(trip: widget, animation: animation));
}
