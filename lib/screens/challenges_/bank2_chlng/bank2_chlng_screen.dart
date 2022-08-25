import 'package:animations_anatomy/screens/challenges_/bank2_chlng/bank2_appbar.dart';
import 'package:animations_anatomy/screens/challenges_/bank2_chlng/bank2_appear_date.dart';
import 'package:animations_anatomy/screens/challenges_/bank2_chlng/bank2_delegate.dart';
import 'package:flutter/material.dart';

class BankChlng2Screen extends StatefulWidget {
  const BankChlng2Screen({Key? key}) : super(key: key);
  @override
  State<BankChlng2Screen> createState() => _BankChlng2ScreenState();
}

class _BankChlng2ScreenState extends State<BankChlng2Screen> {
  final _controller = ScrollController();
  final headerNotifier = ValueNotifier<_MyHeader?>(null);
  final _scrollVal = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onListen);
  }

  void _onListen() => _scrollVal.value = _controller.offset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              controller: _controller,
              slivers: [
                ValueListenableBuilder<double>(
                  valueListenable: _scrollVal,
                  builder: (context, double val, _) => Bank2AppBar(value: val),
                ),
                ...[
                  SliverPersistentHeader(
                    delegate: Bank2Delegate('Recent Transaction',
                        (val) => _refreshHeader('April', val)),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ListTile(
                          title: Text('Hello    $index',
                              style: const TextStyle(color: Colors.white))),
                      childCount: 15,
                    ),
                  ),
                ],
                ...[
                  SliverPersistentHeader(
                    delegate: Bank2Delegate('May 18',
                        (val) => _refreshHeader('May', val, lastOne: 'April')),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ListTile(
                          title: Text('Jb    $index',
                              style: const TextStyle(color: Colors.white))),
                      childCount: 15,
                    ),
                  ),
                ]
              ],
            ),
            ValueListenableBuilder<_MyHeader?>(
              valueListenable: headerNotifier,
              builder: (context, val, _) {
                final _visible = val?.visible ?? false;
                final _title = val?.title ?? '';
                return Bank2AppearDate(visible: _visible, title: _title);
              },
            ),
            Positioned(
              top: 5,
              right: 10,
              child: CircleAvatar(
                backgroundColor: Colors.grey[800],
                child: const Icon(Icons.compare_arrows_sharp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _refreshHeader(String title, bool visible, {String? lastOne}) {
    final headerVal = headerNotifier.value;
    final _headTitle = headerVal?.title ?? title;
    final _headVisible = headerVal?.visible ?? false;
    if (_controller.offset > 0 &&
        (_headTitle != title || lastOne != null || _headVisible != visible)) {
      Future.microtask(() {
        if (!visible && lastOne != null) {
          headerNotifier.value = _MyHeader(lastOne, true);
        } else {
          headerNotifier.value = _MyHeader(title, visible);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onListen);
    _controller.dispose();
    super.dispose();
  }
}

class _MyHeader {
  final String title;
  final bool visible;

  _MyHeader(this.title, this.visible);
}
