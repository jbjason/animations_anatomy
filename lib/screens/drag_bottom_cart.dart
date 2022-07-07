import 'package:animations_anatomy/models/book.dart';
import 'package:animations_anatomy/provider/drag_bottom.dart';
import 'package:animations_anatomy/screens/drag_bottom_details.dart';
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
  final _bloc = DragBottom();

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
                  title: const Text('Drag Challenge'),
                  backgroundColor: Colors.grey[900],
                  leading: IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      icon: const Icon(Icons.menu)),
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
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(30)),
                    color: Colors.grey[800],
                  ),
                  child: const StaggeredViewItem(),
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
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: books.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => DragBottomDetails(book: books[index]))),
        child: Container(
          height: 200,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Hero(
              tag: books[index].image,
              child: Image.asset(books[index].image, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cartList(BuildContext context) {
    final _books = Provider.of<DragBottom>(context).cartItems;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          _books.length,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: _books[index].image + _books[index].title,
              child: CircleAvatar(
                backgroundImage: AssetImage(_books[index].image),
                backgroundColor: Colors.white,
                radius: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StaggeredViewItem extends StatelessWidget {
  const StaggeredViewItem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        pattern: [
          const WovenGridTile(1),
          const WovenGridTile(5 / 7,
              crossAxisRatio: 0.9, alignment: AlignmentDirectional.centerEnd),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Hero(
                      tag: books[index].image,
                      child:
                          Image.asset(books[index].image, fit: BoxFit.cover)),
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
                  books[index].title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 14),
                ),
                Text(
                  books[index].author,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
