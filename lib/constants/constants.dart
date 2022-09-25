import 'package:flutter/material.dart';

const backGradient =
    LinearGradient(colors: [Color(0xFF4b6889), Color(0xFF9FB4D2)]);

const detailsText =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat';

const primaryColor = Color(0xFFCADCED);
final customShadow = [
  BoxShadow(
    color: Colors.white.withOpacity(0.2),
    spreadRadius: 5,
    offset: const Offset(-5, -5),
    blurRadius: 30,
  ),
  BoxShadow(
    color: Colors.blue[900]!.withOpacity(0.2),
    spreadRadius: 2,
    offset: const Offset(7, 7),
    blurRadius: 20,
  ),
];
