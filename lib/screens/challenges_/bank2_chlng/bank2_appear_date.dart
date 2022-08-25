import 'package:flutter/material.dart';

class Bank2AppearDate extends StatelessWidget {
  const Bank2AppearDate({
    Key? key,
    required bool visible,
    required String title,
  })  : _visible = visible,
        _title = title,
        super(key: key);

  final bool _visible;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      height: 60,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        layoutBuilder: (currentChild, previousChild) {
          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              ...previousChild,
              if (currentChild != null) currentChild
            ],
          );
        },
        transitionBuilder: (widget, animation) {
          return FadeTransition(
            opacity: animation,
            child: SizeTransition(sizeFactor: animation, child: widget),
          );
        },
        child: _visible
            ? Container(
                key: Key(_title),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.grey[800]),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _title,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
