import 'package:animations_anatomy/models/book.dart';
import 'package:animations_anatomy/provider/drag_bottom_bloc.dart';
import 'package:animations_anatomy/screens/challenges_/drag_bottom/drag_bottom_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

const _appBarHeight = kToolbarHeight;

class DragBottomCart extends StatefulWidget {
  const DragBottomCart({Key? key}) : super(key: key);
  @override
  State<DragBottomCart> createState() => _DragBottomCartState();
}

class _DragBottomCartState extends State<DragBottomCart> {
  final _bloc = DragBottomBloc();

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: AnimatedBuilder(
          animation: _bloc,
          builder: (context, _) => Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: _appBarHeight,
                child: AppBar(
                  centerTitle: true,
                  title: const Text('Drag Challenge',
                      style: TextStyle(color: Colors.black)),
                  elevation: 30,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      icon: const Icon(Icons.menu, color: Colors.black)),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInCubic,
                top: _getBodyContainerTop(size, _bloc.currentState),
                left: 0,
                right: 0,
                height: size.height - _appBarHeight * 3,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(30)),
                  ),
                  child: _listView(),
                ),
              ),
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
                    child: _cartList(context),
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
    return GridView.custom(
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        pattern: [
          const WovenGridTile(1),
          const WovenGridTile(5 / 7,
              crossAxisRatio: 0.9, alignment: AlignmentDirectional.centerEnd),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) => StaggeredViewItem(book: books[index]),
        childCount: books.length,
      ),
    );
  }

  Widget _cartList(BuildContext context) {
    final _books = Provider.of<DragBottomBloc>(context).cartItems;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Cart : ',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      _books.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Hero(
                          tag: _books[index].image + _books[index].title,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(_books[index].image),
                            radius: 23,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 26,
                backgroundColor: const Color.fromARGB(255, 211, 164, 94),
                child: Text(
                  _books.length.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StaggeredViewItem extends StatelessWidget {
  const StaggeredViewItem({Key? key, required this.book}) : super(key: key);
  final Book book;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => DragBottomDetails(book: book))),
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Hero(
                    tag: book.image,
                    child: Image.asset(book.image, fit: BoxFit.cover)),
              ),
            ),
            const Text(
              '\$ 18.45',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
            const SizedBox(height: 7),
            Text(
              book.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 14),
            ),
            Text(
              book.author,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
