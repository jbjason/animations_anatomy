import 'package:flutter/material.dart';

class HotAndIceButtons extends StatefulWidget {
  const HotAndIceButtons({Key? key, required this.size}) : super(key: key);
  final Size size;
  @override
  State<HotAndIceButtons> createState() => _HotAndIceButtonsState();
}

class _HotAndIceButtonsState extends State<HotAndIceButtons> {
  bool _isHot = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ice image
        AnimatedPositioned(
          duration: const Duration(milliseconds: 350),
          curve: Curves.decelerate,
          right: _isHot ? widget.size.width / 2.5 : -75,
          bottom: _isHot ? widget.size.height / 2.5 : widget.size.height * .18,
          height: _isHot ? 100 : 350,
          width: _isHot ? 100 : 350,
          child:
              Image.asset('assets/coffee_/ice_cubes.png', fit: BoxFit.contain),
        ),
        // bottom Flat-buttons
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          height: widget.size.height * .15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              textButton('Hot/Warm', () => setState(() => _isHot = true),
                  _isHot ? 1 : 0),
              textButton('Cold/Ice', () => setState(() => _isHot = false),
                  _isHot ? 0 : 1),
            ],
          ),
        ),
      ],
    );
  }

  Widget textButton(String text, Function _onPress, int i) {
    return TextButton(
      onPressed: () => _onPress(),
      style: TextButton.styleFrom(
          primary: i == 1 ? Colors.black : Colors.grey,
          backgroundColor:
              i == 1 ? Colors.white.withOpacity(0.5) : Colors.transparent,
          textStyle: const TextStyle(fontSize: 20),
          elevation: i == 1 ? 20 : 0,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20)),
      child: Text(text),
    );
  }
}
