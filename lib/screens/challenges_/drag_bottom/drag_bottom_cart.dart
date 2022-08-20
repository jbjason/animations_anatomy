import 'package:animations_anatomy/models/book.dart';
import 'package:animations_anatomy/provider/drag_bottom_bloc.dart';
import 'package:animations_anatomy/screens/challenges_/drag_bottom/drag_cart_list.dart';
import 'package:animations_anatomy/screens/challenges_/drag_bottom/drag_stagg_item.dart';
import 'package:flutter/material.dart';

const _appBarHeight = kToolbarHeight;

class DragBottomCart extends StatelessWidget {
  const DragBottomCart({Key? key}) : super(key: key);

  double _getBodyContainerTop(Size size, DragState _state) {
    if (_state == DragState.normal) {
      return _appBarHeight;
    }
    if (_state == DragState.cart) {
      return -(size.height - _appBarHeight * 6);
    }
    return 0;
  }

  double _getCartContainerTop(Size size, DragState _state) {
    if (_state == DragState.normal) {
      return size.height - _appBarHeight * 2;
    }
    if (_state == DragState.cart) {
      return _appBarHeight * 3;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _bloc = DragBottomBloc();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: AnimatedBuilder(
          animation: _bloc,
          builder: (context, _) => Stack(
            children: [
              // appBar
              _appBar(context),
              // body
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInCubic,
                top: _getBodyContainerTop(size, _bloc.currentState),
                left: 0,
                right: 0,
                height: size.height - _appBarHeight * 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(30)),
                  ),
                  child: _listView(),
                ),
              ),
              // Cart
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.decelerate,
                top: _getCartContainerTop(size, _bloc.currentState),
                left: 0,
                right: 0,
                height: size.height,
                child: GestureDetector(
                  onVerticalDragUpdate: (val) {
                    if (-val.delta.dy > 4) {
                      _bloc.changeToCart();
                    } else if (val.delta.dy > 7) {
                      _bloc.changeToNormal();
                    }
                  },
                  child: Container(
                    color: Colors.grey[900],
                    child: const DragCartList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          const itemHeight = 200.0;
          final height = constraints.maxHeight + itemHeight;
          return ClipRRect(
            child: OverflowBox(
              maxWidth: width,
              minWidth: width,
              maxHeight: height,
              minHeight: height,
              child: GridView.builder(
                padding: const EdgeInsets.only(
                    top: itemHeight / 2, bottom: itemHeight),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 10),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return DragStaggItem(
                      book: books[index], index: index, itemHeight: itemHeight);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _appBar(BuildContext context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: _appBarHeight,
        child: AppBar(
          centerTitle: true,
          title: const Text('Drag Challenge'),
          elevation: 30,
          backgroundColor: Colors.grey[800],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(60))),
          leading: IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(Icons.menu),
          ),
        ),
      );
}
