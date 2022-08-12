import 'dart:math';
import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 500);

class Drawer2ChlngScreen extends StatelessWidget {
  const Drawer2ChlngScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _appBar(context),
            const SizedBox(height: 20),
            _gridView(),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) => AppBar(
        title: const Text('Drawer2 Challenge'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: _duration,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    DrawerItemList(animation: animation)));
          },
          icon: const Icon(Icons.menu),
        ),
      );
  Widget _gridView() => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisExtent: 200,
              mainAxisSpacing: 20,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return TweenAnimationBuilder(
                tween: Tween<double>(begin: -90, end: 0),
                duration: _duration,
                builder: (context, double val, _) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(val * pi / 180),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/card_/${1 + index}.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
}

class DrawerItemList extends StatefulWidget {
  const DrawerItemList({Key? key, required this.animation}) : super(key: key);
  final Animation<double> animation;
  @override
  State<DrawerItemList> createState() => _DrawerItemListState();
}

class _DrawerItemListState extends State<DrawerItemList> {
  final _val = ValueNotifier<Widget>(Container());
  bool _isRender = false;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Future.delayed(_duration).then((value) => );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 200),
          const Text('jb jason'),
          Expanded(
            child: _isRender
                ? ValueListenableBuilder(
                    valueListenable: _val,
                    builder: (context, Widget value, _) => ListView.builder(
                      itemCount: _categoryList.length,
                      itemBuilder: (context, i) {
                        _addCategory(_categoryList[i]);
                        return Row(children: [value]);
                      },
                    ),
                  )
                : Container(),
          ),
          SizedBox(
            height: 100,
            width: 200,
            child: ElevatedButton(
              child: const Text('Press'),
              onPressed: () {
                setState(() {
                  _isRender = true;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addCategory(String cat) {
    String _text = '';
    List<Widget> _a = [];
    for (int i = 0; i < cat.length; i++) {
      _text += cat[i];
      print(_text);
      _val.value = Text(
        _text,
        style: const TextStyle(fontSize: 30, color: Colors.black),
      );
      // print(_text);
      // _a.add(TweenAnimationBuilder(
      //     tween: Tween<double>(begin: 0, end: 1),
      //     duration: const Duration(milliseconds: 400),
      //     builder: (context, val, _) => Text(
      //           _text,
      //           style: const TextStyle(fontSize: 30, color: Colors.black),
      //         )));
      // _text = '';
      // Timer(const Duration(milliseconds: 200), () {
      //   Future(() {}).then((_) {
      //     return Future.delayed(const Duration(milliseconds: 200), () async {
      //       // _a.add(Text(
      //       //   _text,
      //       //   style: const TextStyle(fontSize: 30, color: Colors.black),
      //       // ));
      //       _val.value = Text(
      //         _text,
      //         style: const TextStyle(fontSize: 30, color: Colors.black),
      //       );
      //       // setState(() {});
      //     });
      //   });
      // });
    }
  }
}

const List<String> _categoryList = [
  'WRIST WATCH',
  'LEATHER GOODS',
  'PERFUME',
  'JEWELLERY',
  'SKINCARE',
];
