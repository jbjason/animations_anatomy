import 'package:animations_anatomy/models/ticket.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/ticket_chlng/ticket_item_details.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

const _minSize = 110.0;
const _duration = Duration(milliseconds: 800);
const _imageRightMargin = 15.0;
const _imageSmallSize = 55.0;
const _imageMaxSize = 130.0;

class TicketBottomNav extends StatefulWidget {
  const TicketBottomNav({Key? key}) : super(key: key);
  @override
  State<TicketBottomNav> createState() => _TicketBottomNavState();
}

class _TicketBottomNavState extends State<TicketBottomNav>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _duration);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        height: lerpDouble(_minSize, _media.size.height, _controller.value),
        child: GestureDetector(
          onTap: () {
            _controller.isDismissed
                ? _controller.forward(from: 0.0)
                : _controller.reverse();
          },
          onVerticalDragUpdate: (dragDetail) {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF162A49),
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(lerpDouble(30, 0, _controller.value)!)),
            ),
            child: Stack(
              children: [
                Positioned(
                  top:
                      lerpDouble(0, _media.padding.top + 20, _controller.value),
                  left: 0,
                  child: Text('Booked Exhibition',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: lerpDouble(16, 22, _controller.value))),
                ),
                for (int i = 0; i < tickets.length; i++)
                  _ticketItem(tickets[i], i),
                const Positioned(
                    bottom: 20,
                    right: 0,
                    child: Icon(Icons.menu, color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _ticketItem(Ticket ticket, int index) {
    return Positioned(
      top: _imageTopPadding(index),
      left: _imageLeftPadding(index),
      child: Container(
        width: _ticketItemContainer,
        height: _imageSize,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Row(
          children: [
            Container(
              width: _imageSize,
              height: _imageSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(lerpDouble(20, 0, _controller.value)!),
                  left: const Radius.circular(20),
                ),
                image: DecorationImage(
                    image: AssetImage(ticket.image), fit: BoxFit.cover),
              ),
            ),
            _controller.value == 1
                ? Expanded(child: TicketItemDetails(ticket: ticket))
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  double get _ticketItemContainer {
    final _width = MediaQuery.of(context).size.width * .95;
    return lerpDouble(_imageSmallSize, _width, _controller.value)!;
  }

  double _imageLeftPadding(int i) {
    final _initPad = i * (_imageSmallSize + _imageRightMargin);
    return lerpDouble(_initPad, 0, _controller.value)!;
  }

  double _imageTopPadding(int i) =>
      lerpDouble(30, 100 + i * (20 + _imageMaxSize), _controller.value)!;
  double get _imageSize =>
      lerpDouble(_imageSmallSize, _imageMaxSize, _controller.value)!;
}
